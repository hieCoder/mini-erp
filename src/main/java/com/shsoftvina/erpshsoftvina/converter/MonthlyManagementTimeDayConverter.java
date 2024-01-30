package com.shsoftvina.erpshsoftvina.converter;

import com.shsoftvina.erpshsoftvina.entity.MonthlyManagementTimeDay;
import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.entity.WeeklyManagementTimeDay;
import com.shsoftvina.erpshsoftvina.mapper.UserMapper;
import com.shsoftvina.erpshsoftvina.model.dto.management_time.MonthlyContentDto;
import com.shsoftvina.erpshsoftvina.model.dto.management_time.MonthlyTagetCategoryDto;
import com.shsoftvina.erpshsoftvina.model.dto.management_time.WeeklyDto;
import com.shsoftvina.erpshsoftvina.model.request.managementtime.day.MonthlyRequest;
import com.shsoftvina.erpshsoftvina.model.request.managementtime.calendar.CalendarMonthlyRequest;
import com.shsoftvina.erpshsoftvina.model.request.managementtime.day.SpendingMonthRequest;
import com.shsoftvina.erpshsoftvina.model.response.managementtime.WeeklyManagementTimeDayResponse;
import com.shsoftvina.erpshsoftvina.model.response.managementtime.day.DailyRoutineResponse;
import com.shsoftvina.erpshsoftvina.model.response.managementtime.day.MonthResponse;
import com.shsoftvina.erpshsoftvina.utils.JsonUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.stream.Collectors;

@Component
public class MonthlyManagementTimeDayConverter {

    @Autowired
    private UserMapper userMapper;

    public MonthlyManagementTimeDay toEntity(String userId, CalendarMonthlyRequest monthlyRequest){
        return MonthlyManagementTimeDay.builder()
                .code(monthlyRequest.getMonth())
                .content(JsonUtils.objectToJson(monthlyRequest.getContent()))
                .color(JsonUtils.objectToJson(monthlyRequest.getColor()))
                .user(userMapper.findById(userId)).build();
    }

    public MonthlyManagementTimeDay toEntity(String userId, MonthlyRequest monthlyRequest){
        return MonthlyManagementTimeDay.builder()
                .code(monthlyRequest.getMonth())
                .content(JsonUtils.objectToJson(monthlyRequest.getContent()))
                .targetCategory(JsonUtils.objectToJson(monthlyRequest.getTargetCategory()))
                .user(userMapper.findById(userId)).build();
    }

    public MonthlyManagementTimeDay toEntity(String userId, String code, String content, String dailyRoutine, String targetCategory, String gratitudeDiary, String compliment, String reflectionAndImprovement){
        return MonthlyManagementTimeDay.builder()
                .code(code)
                .content(content)
                .dailyRoutine(dailyRoutine)
                .targetCategory(targetCategory)
                .gratitudeDiary(gratitudeDiary)
                .compliment(compliment)
                .reflectionAndImprovement(reflectionAndImprovement)
                .user(userMapper.findById(userId)).build();
    }

    public MonthlyManagementTimeDay toEntity(SpendingMonthRequest spendingMonthRequest){
        return MonthlyManagementTimeDay.builder()
                .code(spendingMonthRequest.getMonth())
                .spendingGoals(spendingMonthRequest.getSpendingGoals())
                .user(User.builder().id(spendingMonthRequest.getUserId()).build()).build();
    }

    public MonthResponse toResponse(MonthlyManagementTimeDay monthlyManagementTimeDay){
        return MonthResponse.builder()
                .month(monthlyManagementTimeDay.getCode())
                .dailyRoutine(JsonUtils.jsonToObject(monthlyManagementTimeDay.getDailyRoutine(), DailyRoutineResponse[].class))
                .monthlyContents(JsonUtils.jsonToObject(monthlyManagementTimeDay.getContent(), MonthlyContentDto[].class))
                .color(JsonUtils.jsonToObject(monthlyManagementTimeDay.getColor(), String[].class))
                .targetCategory(JsonUtils.jsonToObject(monthlyManagementTimeDay.getTargetCategory(), MonthlyTagetCategoryDto[].class))
                .build();
    }

    public List<MonthResponse> toListEntity(List<MonthlyManagementTimeDay> monthlyManagementTimeDays) {
        return monthlyManagementTimeDays.stream().map(this::toResponse).collect(Collectors.toList());
    }
}
