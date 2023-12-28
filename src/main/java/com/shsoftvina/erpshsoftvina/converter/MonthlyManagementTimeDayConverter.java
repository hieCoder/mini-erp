package com.shsoftvina.erpshsoftvina.converter;

import com.shsoftvina.erpshsoftvina.entity.MonthlyManagementTimeDay;
import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.mapper.UserMapper;
import com.shsoftvina.erpshsoftvina.model.request.managementtime.day.MonthlyRequest;
import com.shsoftvina.erpshsoftvina.model.request.managementtime.calendar.CalendarMonthlyRequest;
import com.shsoftvina.erpshsoftvina.model.request.managementtime.day.SpendingMonthRequest;
import com.shsoftvina.erpshsoftvina.utils.JsonUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class MonthlyManagementTimeDayConverter {

    @Autowired
    private UserMapper userMapper;

    public MonthlyManagementTimeDay toEntity(String userId, CalendarMonthlyRequest monthlyRequest){
        return MonthlyManagementTimeDay.builder()
                .code(monthlyRequest.getMonth())
                .content(JsonUtils.objectToJson(monthlyRequest.getContent()))
                .user(userMapper.findById(userId)).build();
    }

    public MonthlyManagementTimeDay toEntity(String userId, MonthlyRequest monthlyRequest){
        return MonthlyManagementTimeDay.builder()
                .code(monthlyRequest.getMonth())
                .content(JsonUtils.objectToJson(monthlyRequest.getContent()))
                .user(userMapper.findById(userId)).build();
    }

    public MonthlyManagementTimeDay toEntity(String userId, String code, String content, String dailyRoutine, String incomeCosts, String fixedCost, String fluctuatingCost){
        return MonthlyManagementTimeDay.builder()
                .code(code)
                .content(content)
                .dailyRoutine(dailyRoutine)
                .incomeThisMonth(incomeCosts)
                .fixedCosts(fixedCost)
                .fluctuatingCosts(fluctuatingCost)
                .user(userMapper.findById(userId)).build();
    }

    public MonthlyManagementTimeDay toEntity(SpendingMonthRequest spendingMonthRequest){
        return MonthlyManagementTimeDay.builder()
                .code(spendingMonthRequest.getMonth())
                .spendingGoals(spendingMonthRequest.getSpendingGoals())
                .user(User.builder().id(spendingMonthRequest.getUserId()).build()).build();
    }
}
