package com.shsoftvina.erpshsoftvina.converter;

import com.shsoftvina.erpshsoftvina.entity.ManagementTimeDay;
import com.shsoftvina.erpshsoftvina.entity.WeeklyManagementTimeDay;
import com.shsoftvina.erpshsoftvina.mapper.UserMapper;
import com.shsoftvina.erpshsoftvina.mapper.WeeklyManagementTimeDayMapper;
import com.shsoftvina.erpshsoftvina.model.request.managementtime.WeeklyRequest;
import com.shsoftvina.erpshsoftvina.model.response.managementtime.calendar.CalendarWeeklyContent;
import com.shsoftvina.erpshsoftvina.model.response.managementtime.day.DayResponse;
import com.shsoftvina.erpshsoftvina.model.response.managementtime.day.WeeklyManagementTimeDayResponse;
import com.shsoftvina.erpshsoftvina.utils.DateUtils;
import com.shsoftvina.erpshsoftvina.utils.JsonUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.*;

@Component
public class WeeklyManagementTimeDayConverter {

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private WeeklyManagementTimeDayMapper weeklyManagementTimeDayMapper;

    @Autowired
    private ManagementTimeDayConvert managementTimeDayConvert;

    public WeeklyManagementTimeDay toEntity(String userId, WeeklyRequest weeklyRequest){
        return WeeklyManagementTimeDay.builder()
                .code(DateUtils.formatDate(weeklyRequest.getStartDay()))
                .content(JsonUtils.objectToJson(weeklyRequest.getContent()))
                .user(userMapper.findById(userId)).build();
    }

    public WeeklyManagementTimeDay toEntity(String userId, String code, String content){
        return WeeklyManagementTimeDay.builder()
                .code(code)
                .content(content)
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
}
