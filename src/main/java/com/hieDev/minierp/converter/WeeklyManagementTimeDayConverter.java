package com.hieDev.minierp.converter;

import com.hieDev.minierp.entity.WeeklyManagementTimeDay;
import com.hieDev.minierp.mapper.UserMapper;
import com.hieDev.minierp.model.dto.management_time.WeeklyDto;
import com.hieDev.minierp.model.request.managementtime.WeeklyRequest;
import com.hieDev.minierp.model.request.managementtime.WeeklyRequestReview;
import com.hieDev.minierp.model.response.managementtime.WeeklyManagementTimeDayResponse;
import com.hieDev.minierp.utils.DateUtils;
import com.hieDev.minierp.utils.JsonUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Component
public class WeeklyManagementTimeDayConverter {

    @Autowired
    private UserMapper userMapper;

    public WeeklyManagementTimeDay toEntity(String userId, WeeklyRequest weeklyRequest){
        return WeeklyManagementTimeDay.builder()
                .code(DateUtils.formatDate(weeklyRequest.getStartDay()))
                .content(JsonUtils.objectToJson(weeklyRequest.getWeeklys()))
                .user(userMapper.findById(userId)).build();
    }

    public WeeklyManagementTimeDay toEntityReview(String userId, WeeklyRequestReview weeklyRequestReview){
        return WeeklyManagementTimeDay.builder()
                .code(DateUtils.formatDate(weeklyRequestReview.getStartDay()))
                .gratitudeDiary(weeklyRequestReview.getGratitudeDiary())
                .compliment(weeklyRequestReview.getCompliment())
                .reflectionAndImprovement(weeklyRequestReview.getReflectionAndImprovement())
                .user(userMapper.findById(userId)).build();
    }

    public List<WeeklyManagementTimeDay> toListEntity(String userId, List<WeeklyRequest> weeklyRequests){
        List<WeeklyManagementTimeDay> list = new ArrayList<>();
        for(WeeklyRequest w: weeklyRequests){
            list.add(toEntity(userId, w));
        }
        return list;
    }

    public WeeklyManagementTimeDay toEntity(String userId, String code, String content, String gratitudeDiary, String compliment, String reflectionAndImprovement){
        return WeeklyManagementTimeDay.builder()
                .code(code)
                .content(content)
                .gratitudeDiary(gratitudeDiary)
                .compliment(compliment)
                .reflectionAndImprovement(reflectionAndImprovement)
                .user(userMapper.findById(userId)).build();
    }

    public WeeklyManagementTimeDayResponse toResponse(WeeklyManagementTimeDay weeklyManagementTimeDay){
        return WeeklyManagementTimeDayResponse.builder()
                .weeklyId(weeklyManagementTimeDay.getId())
                .startDate(weeklyManagementTimeDay.getCode())
                .weeklys(JsonUtils.jsonToObject(weeklyManagementTimeDay.getContent(), WeeklyDto[].class))
                .gratitudeDiary(weeklyManagementTimeDay.getGratitudeDiary())
                .compliment(weeklyManagementTimeDay.getCompliment())
                .reflectionAndImprovement(weeklyManagementTimeDay.getReflectionAndImprovement())
                .build();

    }

    public List<WeeklyManagementTimeDayResponse> toListResponse(List<WeeklyManagementTimeDay> weeklyManagementTimeDays){
        return weeklyManagementTimeDays.stream().map(this::toResponse).collect(Collectors.toList());
    }
}
