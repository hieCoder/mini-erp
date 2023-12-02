package com.shsoftvina.erpshsoftvina.converter;

import com.shsoftvina.erpshsoftvina.entity.ColorManagementTimeDay;
import com.shsoftvina.erpshsoftvina.entity.ManagementTimeDay;
import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.model.dto.management_time.DataOfDayDto;
import com.shsoftvina.erpshsoftvina.model.dto.management_time.ItemDto;
import com.shsoftvina.erpshsoftvina.model.dto.management_time.ToDoListDto;
import com.shsoftvina.erpshsoftvina.model.request.managementtime.calendar.CalendarDayRequest;
import com.shsoftvina.erpshsoftvina.model.request.managementtime.day.ColorRequest;
import com.shsoftvina.erpshsoftvina.model.request.managementtime.day.DayRequest;
import com.shsoftvina.erpshsoftvina.model.response.managementtime.calendar.CalendarDayResponse;
import com.shsoftvina.erpshsoftvina.model.response.managementtime.day.ColorResponse;
import com.shsoftvina.erpshsoftvina.model.response.managementtime.day.DayResponse;
import com.shsoftvina.erpshsoftvina.utils.ApplicationUtils;
import com.shsoftvina.erpshsoftvina.utils.DateUtils;
import com.shsoftvina.erpshsoftvina.utils.JsonUtils;
import org.springframework.stereotype.Component;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.TemporalAdjusters;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@Component
public class ColorManagementTimeDayConvert {

    public ColorManagementTimeDay toEntity(String userId, ColorRequest colorRequest){
        return ColorManagementTimeDay.builder()
                .id(ApplicationUtils.generateId())
                .category(colorRequest.getCategory())
                .color(colorRequest.getColor())
                .values(JsonUtils.objectToJson(colorRequest.getValues()))
                .user(User.builder().id(userId).build())
                .build();
    }

    public List<ColorManagementTimeDay> toListEntity(String userId, ColorRequest[] colorRequests){
        List<ColorManagementTimeDay> list = new ArrayList<>();
        for(ColorRequest colorManagementTimeDay: colorRequests){
            list.add(toEntity(userId, colorManagementTimeDay));
        }
        return list;
    }

    public ColorResponse toResponse(ColorManagementTimeDay colorManagementTimeDay){
        return ColorResponse.builder()
                .id(colorManagementTimeDay.getId())
                .category(colorManagementTimeDay.getCategory())
                .color(colorManagementTimeDay.getColor())
                .values(JsonUtils.jsonToObject(colorManagementTimeDay.getValues(), String[].class))
                .build();
    }

    public List<ColorResponse> toListResponse(List<ColorManagementTimeDay> colorManagementTimeDays){
        return colorManagementTimeDays.stream().map(this::toResponse).collect(Collectors.toList());
    }
}
