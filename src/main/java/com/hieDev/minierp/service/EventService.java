package com.hieDev.minierp.service;

import com.hieDev.minierp.model.request.event.EventCreateRequest;
import com.hieDev.minierp.model.request.event.EventEditRequest;
import com.hieDev.minierp.model.response.event.DashBoardResponse;
import com.hieDev.minierp.model.response.event.EventNotificationResponse;
import com.hieDev.minierp.model.response.event.EventResponse;

import java.util.List;

public interface EventService {
    List<EventResponse> getAllEventsByMonth(String month);

    EventResponse createEvent(EventCreateRequest request);

    int editEvent(EventEditRequest request);

    int deleteEvent(String id);

    DashBoardResponse getUpcomingEvent(String day, Integer page, Integer size);

    List<EventNotificationResponse> getEventNotification(Integer limit);
}
