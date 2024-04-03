package com.shsoftvina.erpshsoftvina.converter;

import com.shsoftvina.erpshsoftvina.entity.ColorManagementTimeDay;
import com.shsoftvina.erpshsoftvina.entity.WeeklyManagementTimeDay;
import com.shsoftvina.erpshsoftvina.entity.YearManagementTimeDay;
import com.shsoftvina.erpshsoftvina.model.request.managementtime.day.ColorRequest;
import com.shsoftvina.erpshsoftvina.model.response.managementtime.day.ColorResponse;
import com.shsoftvina.erpshsoftvina.utils.ApplicationUtils;
import com.shsoftvina.erpshsoftvina.utils.JsonUtils;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Component
public class ColorManagementTimeDayConvert {

    public ColorManagementTimeDay toEntity(YearManagementTimeDay year, ColorRequest colorRequest){
        return ColorManagementTimeDay.builder()
                .id(ApplicationUtils.generateId())
                .category(colorRequest.getCategory())
                .color(colorRequest.getColor())
                .values(JsonUtils.objectToJson(colorRequest.getValues()))
                .year(year)
                .build();
    }

    public List<ColorManagementTimeDay> toListEntity(YearManagementTimeDay year, ColorRequest[] colorRequests){
        List<ColorManagementTimeDay> list = new ArrayList<>();
        for(ColorRequest colorManagementTimeDay: colorRequests){
            list.add(toEntity(year, colorManagementTimeDay));
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
