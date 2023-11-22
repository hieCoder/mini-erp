package com.shsoftvina.erpshsoftvina.converter;

import com.shsoftvina.erpshsoftvina.entity.ManagementTimeDay;
import com.shsoftvina.erpshsoftvina.entity.WeeklyManagementTimeDay;
import com.shsoftvina.erpshsoftvina.mapper.UserMapper;
import com.shsoftvina.erpshsoftvina.mapper.WeeklyManagementTimeDayMapper;
import com.shsoftvina.erpshsoftvina.model.request.managementtime.calendar.CalendarWeeklyRequest;
import com.shsoftvina.erpshsoftvina.model.response.managementtime.calendar.CalendarWeeklyContent;
import com.shsoftvina.erpshsoftvina.model.response.managementtime.day.DayResponse;
import com.shsoftvina.erpshsoftvina.model.response.managementtime.day.WeeklyManagementTimeDayResponse;
import com.shsoftvina.erpshsoftvina.utils.ApplicationUtils;
import com.shsoftvina.erpshsoftvina.utils.DateUtils;
import com.shsoftvina.erpshsoftvina.utils.JsonUtils;
import com.shsoftvina.erpshsoftvina.utils.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.time.LocalDate;
import java.util.*;
import java.util.stream.Collectors;

@Component
public class WeeklyManagementTimeDayConverter {

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private WeeklyManagementTimeDayMapper weeklyManagementTimeDayMapper;

    @Autowired
    private ManagementTimeDayConvert managementTimeDayConvert;

    public WeeklyManagementTimeDay toEntity(String userId, CalendarWeeklyRequest calendarWeeklyRequest){
        return WeeklyManagementTimeDay.builder()
                .code(DateUtils.formatDate(calendarWeeklyRequest.getStartDay()))
                .content(JsonUtils.objectToJson(calendarWeeklyRequest.getContent()))
                .user(userMapper.findById(userId)).build();
    }

//    public WeeklyManagementTimeDay createWeeklyManagementTimeDay(String weeklyCode, LocalDate startDate, LocalDate endDate, String userId) {
//        return WeeklyManagementTimeDay.builder()
//                .id(ApplicationUtils.generateId())
//                .code(weeklyCode)
//                .startDate(startDate)
//                .endDate(endDate)
//                .user(userMapper.findById(userId))
//                .build();
//    }
//
//    public WeeklyManagementTimeDay toUpdateWeeklyManagementTimeDay(String id, String content) {
//        WeeklyManagementTimeDay weeklyManagementTimeDay = weeklyManagementTimeDayMapper.findById(id);
//        weeklyManagementTimeDay.setContent(content);
//        return weeklyManagementTimeDay;
//    }
//
//    public WeeklyManagementTimeDayResponse toResponse(WeeklyManagementTimeDay weeklyManagementTimeDay) {
//        String listContent = weeklyManagementTimeDay.getContent();
//        if(listContent != null){
//            String [] contentOfWeekly = listContent.split(",");
//            return WeeklyManagementTimeDayResponse.builder()
//                    .weeklyId(weeklyManagementTimeDay.getId())
//                    .weeklyContents(contentOfWeekly)
//                    .build();
//        }
//        return new WeeklyManagementTimeDayResponse();
//    }

    public List<WeeklyManagementTimeDayResponse> toListWeeklyResponse(String userId, List<ManagementTimeDay> days) {
        Map<String, WeeklyManagementTimeDayResponse> map = new HashMap<>();

        for (ManagementTimeDay d : days) {
            String weeklyCode = d.getWeeklyCode();
            WeeklyManagementTimeDay weeklyE = weeklyManagementTimeDayMapper.findByCode(userId, weeklyCode);

            if (weeklyE != null) {
                if (!map.containsKey(weeklyCode)) {
                    WeeklyManagementTimeDayResponse weeklyRes = new WeeklyManagementTimeDayResponse();
                    weeklyRes.setWeeklyId(weeklyE.getId());
                    weeklyRes.setStartDate(weeklyE.getCode());
                    weeklyRes.setWeeklyContents(JsonUtils.jsonToObject(weeklyE.getContent(), CalendarWeeklyContent.class));
                    weeklyRes.setListDayOfWeek(Arrays.asList(managementTimeDayConvert.toResponse(d)));

                    map.put(weeklyCode, weeklyRes);
                } else {
                    WeeklyManagementTimeDayResponse weeklyRes = map.get(weeklyCode);

                    List<DayResponse> listDayOfWeek = new ArrayList<>(weeklyRes.getListDayOfWeek());
                    listDayOfWeek.add(managementTimeDayConvert.toResponse(d));

                    weeklyRes.setListDayOfWeek(listDayOfWeek);
                    map.put(weeklyCode, weeklyRes);
                }
            }
        }

        List<WeeklyManagementTimeDayResponse> result = new ArrayList<>(map.values());
        return result;
    }



//        List<WeeklyManagementTimeDayResponse> rs = new ArrayList<>();
//
//        Map<String, List<ManagementTimeDay>> groupedByWeeklyCode = days.stream()
//                .collect(Collectors.groupingBy(ManagementTimeDay::getWeeklyCode));
//
//        for (String weeklyCode : groupedByWeeklyCode.keySet()) {
//
//            WeeklyManagementTimeDayResponse weeklyManagementTimeDayResponse = new WeeklyManagementTimeDayResponse();
//
//            WeeklyManagementTimeDay weeklyManagementTimeDay = weeklyManagementTimeDayMapper.findByCode(userId, weeklyCode);
//            if (weeklyManagementTimeDay != null) {
//                weeklyManagementTimeDayResponse.setWeeklyId(weeklyManagementTimeDay.getId());
//                weeklyManagementTimeDayResponse.setStartDate(weeklyManagementTimeDay.getCode());
//                String contentOfWeekly = weeklyManagementTimeDay.getContent();
//                if(!StringUtils.isBlank(contentOfWeekly)){
//                    CalendarWeeklyContent calendarWeeklyContent = JsonUtils.jsonToObject(weeklyManagementTimeDay.getContent(), CalendarWeeklyContent.class);
//                    weeklyManagementTimeDayResponse.setWeeklyContents(calendarWeeklyContent);
//                }
//
//                List<ManagementTimeDay> daysWithSameWeeklyCode = groupedByWeeklyCode.get(weeklyCode);
//                List<DayResponse> listDayOfWeek = daysWithSameWeeklyCode.stream()
//                        .map(day-> managementTimeDayConvert.toResponse(day)).collect(Collectors.toList());
//                weeklyManagementTimeDayResponse.setListDayOfWeek(listDayOfWeek);
//                rs.add(weeklyManagementTimeDayResponse);
//            }
//        }
//        return rs;
}
