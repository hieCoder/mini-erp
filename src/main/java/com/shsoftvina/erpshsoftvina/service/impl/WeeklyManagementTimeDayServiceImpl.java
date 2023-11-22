package com.shsoftvina.erpshsoftvina.service.impl;

import com.shsoftvina.erpshsoftvina.service.WeeklyManagementTimeDayService;
import org.springframework.stereotype.Service;

@Service
public class WeeklyManagementTimeDayServiceImpl implements WeeklyManagementTimeDayService {

//    @Autowired
//    private WeeklyManagementTimeDayMapper weeklyManagementTimeDayMapper;
//
//    @Autowired
//    private WeeklyManagementTimeDayConverter weeklyManagementTimeDayConverter;
//
//    @Override
//    public int updateWeekly(WeeklyManagementTimeDayUpdateRequest weeklyManagementTimeDayUpdateRequest) {
//
//        try{
//            WeeklyManagementTimeDay weeklyManagementTimeDay = weeklyManagementTimeDayConverter.toUpdateWeeklyManagementTimeDay(
//                    weeklyManagementTimeDayUpdateRequest.getId(), weeklyManagementTimeDayUpdateRequest.getContent()
//            );
//            weeklyManagementTimeDayMapper.updateWeeklyManagementTimeDay(weeklyManagementTimeDay);
//            return 1;
//        } catch (Exception e){
//
//        }
//        return 0;
//    }
//
//    @Override
//    public WeeklyManagementTimeDayResponse getWeekly(String id){
//        return weeklyManagementTimeDayConverter.toResponse(weeklyManagementTimeDayMapper.findById(id));
//    }
}
