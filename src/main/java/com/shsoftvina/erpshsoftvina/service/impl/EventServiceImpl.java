package com.shsoftvina.erpshsoftvina.service.impl;

import com.shsoftvina.erpshsoftvina.converter.EventConverter;
import com.shsoftvina.erpshsoftvina.entity.Event;
import com.shsoftvina.erpshsoftvina.mapper.EventMapper;
import com.shsoftvina.erpshsoftvina.mapper.UserMapper;
import com.shsoftvina.erpshsoftvina.model.request.event.EventCreateRequest;
import com.shsoftvina.erpshsoftvina.model.request.event.EventEditRequest;
import com.shsoftvina.erpshsoftvina.model.response.event.EventResponse;
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
    public void createEvent(EventCreateRequest request) {
        Event event = eventConverter.convertToEntity(request);
        event.setUser(userMapper.findById(request.getUserId()));
        eventMapper.createEvent(event);
    }

    @Override
    public void editEvent(EventEditRequest request) {
        Event event = eventConverter.convertToEntity(request);
        event.setUser(userMapper.findById(request.getUserId()));
        eventMapper.editEvent(event);
    }

    @Override
    public void deleteEvent(String id) {
        eventMapper.deleteEvent(id);
    }
}
