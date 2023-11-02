package com.shsoftvina.erpshsoftvina.service.impl;

import com.shsoftvina.erpshsoftvina.converter.EventConverter;
import com.shsoftvina.erpshsoftvina.entity.Event;
import com.shsoftvina.erpshsoftvina.exception.NotFoundException;
import com.shsoftvina.erpshsoftvina.mapper.EventMapper;
import com.shsoftvina.erpshsoftvina.mapper.UserMapper;
import com.shsoftvina.erpshsoftvina.model.request.event.EventCreateRequest;
import com.shsoftvina.erpshsoftvina.model.request.event.EventEditRequest;
import com.shsoftvina.erpshsoftvina.model.response.event.EventDashBoardResponse;
import com.shsoftvina.erpshsoftvina.model.response.event.EventResponse;
import com.shsoftvina.erpshsoftvina.security.Principal;
import com.shsoftvina.erpshsoftvina.service.EventService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EventServiceImpl implements EventService {
    @Autowired
    private EventMapper eventMapper;
    @Autowired
    private UserMapper userMapper;
    @Autowired
    private EventConverter eventConverter;
    @Override
    public List<EventResponse> getAllEventsByMonth(String monthly) {
        List<Event> events = eventMapper.getAllEventsByMonth(monthly);
        return eventConverter.convertToResponse(events);
    }

    @Override
    public String createEvent(EventCreateRequest request) {
        try{
            String id = Principal.getUserCurrent().getId();
            Event event = eventConverter.convertToEntity(request);
            event.setUser(userMapper.findById(id));
            eventMapper.createEvent(event);
            return event.getId();
        } catch(Exception e){
            System.out.println(e);
            return null;
        }
    }

    @Override
    public int editEvent(EventEditRequest request) {
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
        try{
            eventMapper.deleteEvent(id);
            return 1;
        } catch(Exception e){
            System.out.println(e);
            return 0;
        }
    }

    @Override
    public List<EventDashBoardResponse> getUpcomingEvent(String day) {
        List<Event> events = eventMapper.getUpcomingEvents(day);
        return eventConverter.convertToHomeResponse(events);
    }
}
