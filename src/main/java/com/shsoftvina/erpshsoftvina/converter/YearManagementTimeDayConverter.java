package com.shsoftvina.erpshsoftvina.converter;

import com.shsoftvina.erpshsoftvina.entity.MonthlyManagementTimeDay;
import com.shsoftvina.erpshsoftvina.entity.YearManagementTimeDay;
import com.shsoftvina.erpshsoftvina.mapper.UserMapper;
import com.shsoftvina.erpshsoftvina.model.request.managementtime.calendar.CalendarMonthlyRequest;
import com.shsoftvina.erpshsoftvina.model.request.managementtime.day.MonthlyRequest;
import com.shsoftvina.erpshsoftvina.model.request.managementtime.day.YearRequest;
import com.shsoftvina.erpshsoftvina.utils.JsonUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class YearManagementTimeDayConverter {
    @Autowired
    private UserMapper userMapper;

    public YearManagementTimeDay toEntity(String userId, YearRequest yearRequest){
        return YearManagementTimeDay.builder()
                .code(yearRequest.getYear())
                .target(JsonUtils.objectToJson(yearRequest.getContent()))
                .user(userMapper.findById(userId)).build();
    }

//    public MonthlyManagementTimeDay toEntity(String userId, String code, String content, String dailyRoutine, String incomeCosts, String fixedCost, String fluctuatingCost){
//        return MonthlyManagementTimeDay.builder()
//                .code(code)
//                .content(content)
//                .dailyRoutine(dailyRoutine)
//                .incomeThisMonth(incomeCosts)
//                .fixedCosts(fixedCost)
//                .fluctuatingCosts(fluctuatingCost)
//                .user(userMapper.findById(userId)).build();
//    }
}
