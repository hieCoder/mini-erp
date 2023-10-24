package com.shsoftvina.erpshsoftvina.converter;

import com.shsoftvina.erpshsoftvina.entity.ManagementTimeDay;
import com.shsoftvina.erpshsoftvina.entity.WeeklyManagementTimeDay;
import com.shsoftvina.erpshsoftvina.entity.WeeklyReport;
import com.shsoftvina.erpshsoftvina.mapper.ManagementTimeDayMapper;
import com.shsoftvina.erpshsoftvina.mapper.UserMapper;
import com.shsoftvina.erpshsoftvina.mapper.WeeklyManagementTimeDayMapper;
import com.shsoftvina.erpshsoftvina.model.dto.management_time.DataOfDayDto;
import com.shsoftvina.erpshsoftvina.model.dto.management_time.OneThingCalendarDto;
import com.shsoftvina.erpshsoftvina.model.dto.management_time.ToDoListDto;
import com.shsoftvina.erpshsoftvina.model.request.weeklyreport.CreateWeeklyReportRequest;
import com.shsoftvina.erpshsoftvina.model.response.managementtime.day.DayResponse;
import com.shsoftvina.erpshsoftvina.model.response.managementtime.day.WeeklyManagementTimeDayResponse;
import com.shsoftvina.erpshsoftvina.model.response.weeklyReport.WeeklyReportDetailResponse;
import com.shsoftvina.erpshsoftvina.model.response.weeklyReport.WeeklyReportShowResponse;
import com.shsoftvina.erpshsoftvina.utils.ApplicationUtils;
import com.shsoftvina.erpshsoftvina.utils.DateUtils;
import com.shsoftvina.erpshsoftvina.utils.JsonUtils;
import com.shsoftvina.erpshsoftvina.utils.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Component
public class WeeklyManagementTimeDayConverter {

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private WeeklyManagementTimeDayMapper weeklyManagementTimeDayMapper;

    @Autowired
    private ManagementTimeConvert managementTimeConvert;

    public WeeklyManagementTimeDay createWeeklyManagementTimeDay(String weeklyCode, LocalDate startDate, LocalDate endDate, String userId) {
        return WeeklyManagementTimeDay.builder()
                .id(ApplicationUtils.generateId())
                .code(weeklyCode)
                .startDate(startDate)
                .endDate(endDate)
                .user(userMapper.findById(userId))
                .build();
    }

    public WeeklyManagementTimeDay toUpdateWeeklyManagementTimeDay(String id, String content) {
        WeeklyManagementTimeDay weeklyManagementTimeDay = weeklyManagementTimeDayMapper.findById(id);
        weeklyManagementTimeDay.setContent(content);
        return weeklyManagementTimeDay;
    }

    public List<WeeklyManagementTimeDayResponse> toListWeeklyResponse(String userId, List<ManagementTimeDay> days){

        List<WeeklyManagementTimeDayResponse> rs = new ArrayList<>();

        Map<String, List<ManagementTimeDay>> groupedByWeeklyCode = days.stream()
                .collect(Collectors.groupingBy(ManagementTimeDay::getWeeklyCode));

        for (String weeklyCode : groupedByWeeklyCode.keySet()) {

            WeeklyManagementTimeDayResponse weeklyManagementTimeDayResponse = new WeeklyManagementTimeDayResponse();


            WeeklyManagementTimeDay weeklyManagementTimeDay = weeklyManagementTimeDayMapper.findByCodeOfUser(userId, weeklyCode);
            if (weeklyManagementTimeDay != null) {
                weeklyManagementTimeDayResponse.setWeeklyId(weeklyManagementTimeDay.getId());
                weeklyManagementTimeDayResponse.setStartDate(DateUtils.formatDate(weeklyManagementTimeDay.getStartDate()));
                String contentOfWeekly = weeklyManagementTimeDay.getContent();
                if(!StringUtils.isBlank(contentOfWeekly)){
                    weeklyManagementTimeDayResponse.setWeeklyContents(contentOfWeekly.split(","));
                }

                List<ManagementTimeDay> daysWithSameWeeklyCode = groupedByWeeklyCode.get(weeklyCode);
                List<DayResponse> listDayOfWeek = daysWithSameWeeklyCode.stream()
                        .map(day-> managementTimeConvert.toResponse(day)).collect(Collectors.toList());
                weeklyManagementTimeDayResponse.setListDayOfWeek(listDayOfWeek);
                rs.add(weeklyManagementTimeDayResponse);
            }
        }
        return rs;
    }
}
