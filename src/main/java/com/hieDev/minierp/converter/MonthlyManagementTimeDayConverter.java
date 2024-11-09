package com.hieDev.minierp.converter;

import com.hieDev.minierp.entity.MonthlyManagementTimeDay;
import com.hieDev.minierp.entity.User;
import com.hieDev.minierp.mapper.UserMapper;
import com.hieDev.minierp.model.dto.management_time.MonthlyContentDto;
import com.hieDev.minierp.model.dto.management_time.MonthlyTagetCategoryDto;
import com.hieDev.minierp.model.dto.management_time.TimeUsedMonthlyDto;
import com.hieDev.minierp.model.request.managementtime.day.MonthlyRequest;
import com.hieDev.minierp.model.request.managementtime.calendar.CalendarMonthlyRequest;
import com.hieDev.minierp.model.request.managementtime.day.SpendingMonthRequest;
import com.hieDev.minierp.model.response.managementtime.day.DailyRoutineResponse;
import com.hieDev.minierp.model.response.managementtime.day.MonthResponse;
import com.hieDev.minierp.utils.JsonUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.stream.Collectors;

@Component
public class MonthlyManagementTimeDayConverter {

    @Autowired
    private UserMapper userMapper;

    public MonthlyManagementTimeDay toEntity(String userId, CalendarMonthlyRequest monthlyRequest) {
        return MonthlyManagementTimeDay.builder()
                .code(monthlyRequest.getMonth())
                .content(JsonUtils.objectToJson(monthlyRequest.getContent()))
                .user(userMapper.findById(userId)).build();
    }

    public MonthlyManagementTimeDay toEntity(String userId, MonthlyRequest monthlyRequest) {
        return MonthlyManagementTimeDay.builder()
                .code(monthlyRequest.getMonth())
                .content(JsonUtils.objectToJson(monthlyRequest.getContent()))
                .targetCategory(JsonUtils.objectToJson(monthlyRequest.getTargetCategory()))
                .user(userMapper.findById(userId)).build();
    }

    public MonthlyManagementTimeDay toEntity(String userId, String code, String content, String dailyRoutine, String targetCategory, String gratitudeDiary, String compliment, String reflectionAndImprovement, String timeUsedMonthly) {
        return MonthlyManagementTimeDay.builder()
                .code(code)
                .content(content)
                .dailyRoutine(dailyRoutine)
                .targetCategory(targetCategory)
                .gratitudeDiary(gratitudeDiary)
                .compliment(compliment)
                .reflectionAndImprovement(reflectionAndImprovement)
                .timeUsedCategory(timeUsedMonthly)
                .user(userMapper.findById(userId)).build();
    }

    public MonthlyManagementTimeDay toEntity(SpendingMonthRequest spendingMonthRequest) {
        return MonthlyManagementTimeDay.builder()
                .code(spendingMonthRequest.getMonth())
                .spendingGoals(spendingMonthRequest.getSpendingGoals())
                .user(User.builder().id(spendingMonthRequest.getUserId()).build()).build();
    }

    public MonthResponse toResponse(MonthlyManagementTimeDay monthlyManagementTimeDay) {
        return MonthResponse.builder()
                .month(monthlyManagementTimeDay.getCode())
                .dailyRoutine(JsonUtils.jsonToObject(monthlyManagementTimeDay.getDailyRoutine(), DailyRoutineResponse[].class))
                .monthlyContents(JsonUtils.jsonToObject(monthlyManagementTimeDay.getContent(), MonthlyContentDto[].class))
                .targetCategory(JsonUtils.jsonToObject(monthlyManagementTimeDay.getTargetCategory(), MonthlyTagetCategoryDto[].class))
                .timeUsedMonthly(JsonUtils.jsonToObject(monthlyManagementTimeDay.getTimeUsedCategory(), TimeUsedMonthlyDto[].class))
                .build();
    }

    public List<MonthResponse> toListEntity(List<MonthlyManagementTimeDay> monthlyManagementTimeDays) {
        return monthlyManagementTimeDays.stream().map(this::toResponse).collect(Collectors.toList());
    }
}
