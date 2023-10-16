package com.shsoftvina.erpshsoftvina.service.impl;

import com.shsoftvina.erpshsoftvina.converter.ManagementTimeConvert;
import com.shsoftvina.erpshsoftvina.entity.ManagementTimeDay;
import com.shsoftvina.erpshsoftvina.exception.NotFoundException;
import com.shsoftvina.erpshsoftvina.mapper.ManagementTimeDayMapper;
import com.shsoftvina.erpshsoftvina.mapper.UserMapper;
import com.shsoftvina.erpshsoftvina.model.request.managementtime.day.DayCreateRequest;
import com.shsoftvina.erpshsoftvina.model.request.managementtime.day.DayUpdateRequest;
import com.shsoftvina.erpshsoftvina.model.response.managementtime.day.DayResponse;
import com.shsoftvina.erpshsoftvina.service.ManagementTimeDayService;
import com.shsoftvina.erpshsoftvina.utils.JsonUtils;
import com.shsoftvina.erpshsoftvina.utils.MessageErrorUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class ManagementTimeDayServiceImpl implements ManagementTimeDayService {

    @Autowired
    private ManagementTimeConvert managementTimeConvert;

    @Autowired
    private ManagementTimeDayMapper managementTimeDayMapper;

    @Autowired
    private UserMapper userMapper;

    @Override
    public DayResponse createDay(String jsonDay) {
        DayCreateRequest dayCreateRequest = JsonUtils.jsonToObject(jsonDay, DayCreateRequest.class);

        if(userMapper.findById(dayCreateRequest.getUserId()) == null)
            throw new NotFoundException(MessageErrorUtils.notFound("userId"));

        ManagementTimeDay day = managementTimeConvert.toEntity(dayCreateRequest);
        try{
            managementTimeDayMapper.createDayInfo(day);
            return managementTimeConvert.toResponse(day);
        }catch (Exception e){
            return null;
        }
    }

    @Override
    public DayResponse updateDay(String jsonDay) {
        DayUpdateRequest updateRequest = JsonUtils.jsonToObject(jsonDay, DayUpdateRequest.class);

        if(managementTimeDayMapper.findById(updateRequest.getId()) == null)
            throw new NotFoundException(MessageErrorUtils.notFound("id"));

        ManagementTimeDay day = managementTimeConvert.toEntity(updateRequest);
        try{
            managementTimeDayMapper.updateDayInfo(day);
            return managementTimeConvert.toResponse(day);
        }catch (Exception e){
            return null;
        }
    }

    @Override
    public DayResponse findById(String id) {
        return managementTimeConvert.toResponse(managementTimeDayMapper.findById(id));
    }

    @Override
    public List<DayResponse> findAllByMonthYear(String userId, String month, String year) {

        if(userMapper.findById(userId) == null)
            throw new NotFoundException(MessageErrorUtils.notFound("userId"));

        return managementTimeDayMapper.findAllByMonthYear(userId, month, year)
                .stream().map(day -> managementTimeConvert.toResponse(day))
                .collect(Collectors.toList());
    }
}