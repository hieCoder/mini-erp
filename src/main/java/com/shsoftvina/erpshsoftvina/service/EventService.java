package com.shsoftvina.erpshsoftvina.service;

import com.shsoftvina.erpshsoftvina.model.request.event.EventCreateRequest;
import com.shsoftvina.erpshsoftvina.model.request.event.EventEditRequest;
import com.shsoftvina.erpshsoftvina.model.response.event.EventResponse;

import java.util.List;

public interface EventService {
    List<EventResponse> getAllEventsByMonth(String month);

    void createEvent(EventCreateRequest request);

    void editEvent(EventEditRequest request);

    void deleteEvent(String id);
}
