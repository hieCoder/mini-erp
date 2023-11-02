package com.shsoftvina.erpshsoftvina.converter;

import com.shsoftvina.erpshsoftvina.entity.Event;
import com.shsoftvina.erpshsoftvina.enums.event.EventTypeEnum;
import com.shsoftvina.erpshsoftvina.model.dto.EnumDto;
import com.shsoftvina.erpshsoftvina.model.request.event.EventCreateRequest;
import com.shsoftvina.erpshsoftvina.model.request.event.EventEditRequest;
import com.shsoftvina.erpshsoftvina.model.response.event.EventResponse;
import com.shsoftvina.erpshsoftvina.utils.ApplicationUtils;
import com.shsoftvina.erpshsoftvina.utils.DateUtils;
import com.shsoftvina.erpshsoftvina.utils.EnumUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.stream.Collectors;

@Component
public class EventConverter {
    @Autowired
    private UserConverter userConverter;
    public List<EventResponse> convertToResponse(List<Event> events) {
        return events.stream().map(this::convertToResponse).collect(Collectors.toList());
    }

    public EventResponse convertToResponse(Event event) {
        String parseStartDate = DateUtils.formatDateTime(event.getStartDate());
        String parseEndDate = DateUtils.formatDateTime(event.getEndDate());
        return EventResponse.builder()
                .content(event.getContent())
                .endDate(parseEndDate)
                .startDate(parseStartDate)
                .id(event.getId())
                .title(event.getTitle())
                .type(EnumUtils.instance(event.getType()))
                .user(userConverter.toIdAndFullnameUserResponse(event.getUser()))
                .build();
    }

    public Event convertToEntity(EventCreateRequest request) {
        return Event.builder()
                .type(EnumUtils.getEnumFromValue(EventTypeEnum.class,request.getType()))
                .id(ApplicationUtils.generateId())
                .content(request.getContent())
                .endDate(DateUtils.parseDateTime(request.getEndDate()))
                .startDate(DateUtils.parseDateTime(request.getStartDate()))
                .title(request.getTitle())
                .build();
    }

    public Event convertToEntity(EventEditRequest request) {
        return Event.builder()
                .type(EnumUtils.getEnumFromValue(EventTypeEnum.class,request.getType()))
                .id(request.getId())
                .content(request.getContent())
                .endDate(DateUtils.parseDateTime(request.getEndDate()))
                .startDate(DateUtils.parseDateTime(request.getStartDate()))
                .title(request.getTitle())
                .build();
    }
}
