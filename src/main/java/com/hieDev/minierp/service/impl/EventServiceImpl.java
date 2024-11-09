package com.hieDev.minierp.service.impl;

import com.hieDev.minierp.converter.EventConverter;
import com.hieDev.minierp.exception.NotFoundException;
import com.hieDev.minierp.model.request.event.EventCreateRequest;
import com.hieDev.minierp.model.request.event.EventEditRequest;
import com.hieDev.minierp.security.Principal;
import com.hieDev.minierp.entity.Event;
import com.hieDev.minierp.mapper.EventMapper;
import com.hieDev.minierp.mapper.UserMapper;
import com.hieDev.minierp.model.response.event.DashBoardResponse;
import com.hieDev.minierp.model.response.event.EventDashBoardResponse;
import com.hieDev.minierp.model.response.event.EventNotificationResponse;
import com.hieDev.minierp.model.response.event.EventResponse;
import com.hieDev.minierp.service.EventService;
import com.hieDev.minierp.utils.ApplicationUtils;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.temporal.TemporalAdjusters;
import java.util.List;

@Service
public class EventServiceImpl implements EventService {
    @Autowired
    private EventMapper eventMapper;
    @Autowired
    private UserMapper userMapper;
    @Autowired
    private EventConverter eventConverter;
    @Autowired
    private ApplicationUtils applicationUtils;
    @Override
    public List<EventResponse> getAllEventsByMonth(String monthly) {
        String firstDayOfMonth = monthly + "-01";
        LocalDate currentDate = LocalDate.parse(firstDayOfMonth);
        LocalDate previousDate = currentDate.minusMonths(1);
        LocalDate lastDayOfNextMonth = currentDate.plusMonths(1).with(TemporalAdjusters.lastDayOfMonth());
        List<Event> events = eventMapper.getAllEventsByMonth(previousDate,lastDayOfNextMonth);
        return eventConverter.convertToResponse(events);
    }

    @Override
    public EventResponse createEvent(EventCreateRequest request) {
        applicationUtils.checkUserAllow();
        try{
            String id = Principal.getUserCurrent().getId();
            Event event = eventConverter.convertToEntity(request);
            event.setUser(userMapper.findById(id));
            eventMapper.createEvent(event);
            return eventConverter.convertToResponse(event);
        } catch(Exception e){
            System.out.println(e);
            return null;
        }
    }

    @Override
    public int editEvent(EventEditRequest request) {
        applicationUtils.checkUserAllow();
        try{
            Event checkEvent = eventMapper.findById(request.getId());
            if(checkEvent!= null){
                String id = Principal.getUserCurrent().getId();
                Event event = eventConverter.convertToEntity(request);
                event.setUser(userMapper.findById(id));
                int rs = eventMapper.editEvent(event);
                return rs;
            } else{
                throw new NotFoundException("Not found event");
            }
        } catch(Exception e){
            System.out.println(e);
            return 0;
        }
    }

    @Override
    public int deleteEvent(String id) {
        applicationUtils.checkUserAllow();
        try{
            eventMapper.deleteEvent(id);
            return 1;
        } catch(Exception e){
            System.out.println(e);
            return 0;
        }
    }

    @Override
    public DashBoardResponse getUpcomingEvent(String day, Integer page, Integer size) {
        int offset = (page - 1) * size;
        RowBounds rowBounds = new RowBounds(offset, size);
        List<Event> events = eventMapper.getUpcomingEvents(day,rowBounds);
        List<EventDashBoardResponse> list = eventConverter.convertToHomeResponse(events);
        long totalRecordCount = eventMapper.getTotalRecordCountUpcoming(day);
        long totalPage = (long) Math.ceil((double) totalRecordCount / size);
        boolean hasNext = page < totalPage;
        boolean hasPrevious = page > 1;
        return new DashBoardResponse(list,page,totalPage,totalRecordCount,size,hasNext,hasPrevious);
    }

    @Override
    public List<EventNotificationResponse> getEventNotification(Integer limit) {
        List<Event> events = eventMapper.getEventNotification(limit);
        return eventConverter.convertToNotiResponse(events);
    }
}
