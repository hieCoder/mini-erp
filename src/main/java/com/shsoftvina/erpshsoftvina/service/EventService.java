package com.shsoftvina.erpshsoftvina.service;

import com.shsoftvina.erpshsoftvina.model.request.event.EventCreateRequest;
import com.shsoftvina.erpshsoftvina.model.request.event.EventEditRequest;
import com.shsoftvina.erpshsoftvina.model.response.event.DashBoardResponse;
import com.shsoftvina.erpshsoftvina.model.response.event.EventDashBoardResponse;
import com.shsoftvina.erpshsoftvina.model.response.event.EventResponse;

import java.util.List;

public interface EventService {
    List<EventResponse> getAllEventsByMonth(String month);

    EventResponse createEvent(EventCreateRequest request);

    int editEvent(EventEditRequest request);

    int deleteEvent(String id);

    DashBoardResponse getUpcomingEvent(String day, Integer page, Integer size);
}
