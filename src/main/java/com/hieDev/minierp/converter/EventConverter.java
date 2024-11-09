package com.hieDev.minierp.converter;

import com.hieDev.minierp.model.request.event.EventCreateRequest;
import com.hieDev.minierp.model.request.event.EventEditRequest;
import com.hieDev.minierp.entity.Event;
import com.hieDev.minierp.enums.event.EventTypeEnum;
import com.hieDev.minierp.model.response.event.EventDashBoardResponse;
import com.hieDev.minierp.model.response.event.EventNotificationResponse;
import com.hieDev.minierp.model.response.event.EventResponse;
import com.hieDev.minierp.utils.ApplicationUtils;
import com.hieDev.minierp.utils.DateUtils;
import com.hieDev.minierp.utils.EnumUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@Component
public class EventConverter {
    @Autowired
    private UserConverter userConverter;
    public List<EventResponse> convertToResponse(List<Event> events) {
        return events.stream().map(this::convertToResponse).collect(Collectors.toList());
    }

    public List<EventNotificationResponse> convertToNotiResponse(List<Event> events) {
        return events.stream().map(this::convertToNotiResponse).collect(Collectors.toList());
    }

    public List<EventDashBoardResponse> convertToHomeResponse(List<Event> events) {
        return events.stream().map(this::convertToHomeResponse).collect(Collectors.toList());
    }

    public EventNotificationResponse convertToNotiResponse(Event event) {
        return EventNotificationResponse.builder()
                .id(event.getId())
                .title(event.getTitle())
                .createdDate(DateUtils.formatDateTime(event.getCreatedDate()))
                .build();
    }

    public EventResponse convertToResponse(Event event) {
        return EventResponse.builder()
                .content(event.getContent())
                .endDate(event.getEndDate())
                .startDate(event.getStartDate())
                .id(event.getId())
                .title(event.getTitle())
                .type(EnumUtils.instance(event.getType()))
                .user(userConverter.toIdAndFullnameUserResponse(event.getUser()))
                .build();
    }

    public EventDashBoardResponse convertToHomeResponse(Event event) {
        return EventDashBoardResponse.builder()
                .content(event.getContent())
                .endDate(event.getEndDate())
                .startDate(event.getStartDate())
                .id(event.getId())
                .title(event.getTitle())
                .type(EnumUtils.instance(event.getType()))
                .user(userConverter.toFullnameAndAvatarResponse(event.getUser()))
                .build();
    }

    public Event convertToEntity(EventCreateRequest request) {
        return Event.builder()
                .type(EnumUtils.getEnumFromValue(EventTypeEnum.class,request.getType()))
                .id(ApplicationUtils.generateId())
                .content(request.getContent())
                .endDate(request.getEndDate())
                .startDate(request.getStartDate())
                .title(request.getTitle())
                .createdDate(new Date())
                .build();
    }

    public Event convertToEntity(EventEditRequest request) {
        return Event.builder()
                .type(EnumUtils.getEnumFromValue(EventTypeEnum.class,request.getType()))
                .id(request.getId())
                .content(request.getContent())
                .endDate(request.getEndDate())
                .startDate(request.getStartDate())
                .title(request.getTitle())
                .build();
    }
}
