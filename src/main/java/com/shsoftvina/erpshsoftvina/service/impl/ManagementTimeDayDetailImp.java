package com.shsoftvina.erpshsoftvina.service.impl;

import com.shsoftvina.erpshsoftvina.converter.ManagementTimeDayDetailConverter;
import com.shsoftvina.erpshsoftvina.entity.ManagementTimeDayDetail;
import com.shsoftvina.erpshsoftvina.mapper.ManagementTimeDayDetailMapper;
import com.shsoftvina.erpshsoftvina.model.request.managementtime.daydetail.DayDetailCreateRequest;
import com.shsoftvina.erpshsoftvina.model.request.managementtime.daydetail.DayDetailUpdateRequest;
import com.shsoftvina.erpshsoftvina.service.ManagementTimeDayDetailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ManagementTimeDayDetailImp implements ManagementTimeDayDetailService {

    @Autowired
    ManagementTimeDayDetailConverter managementTimeDayDetailConverter;

    @Autowired
    ManagementTimeDayDetailMapper managementTimeDayDetailMapper;

    @Override
    public int createTimeDayDetail(DayDetailCreateRequest dayDetailCreateRequest) {

        ManagementTimeDayDetail dayDetail = managementTimeDayDetailConverter.toEntity(dayDetailCreateRequest);

        try{
            managementTimeDayDetailMapper.createTimeDayDetail(dayDetail);
        } catch (Exception e){
            return 0;
        }

        return 1;
    }

    @Override
    public int updateTimeDayDetail(DayDetailUpdateRequest dayDetailUpdateRequest) {
        ManagementTimeDayDetail dayDetail = managementTimeDayDetailConverter.toUpdateEntity(dayDetailUpdateRequest);

        try{
            managementTimeDayDetailMapper.updateTimeDayDetail(dayDetail);
        } catch (Exception e){
            return 0;
        }
        return 1;
    }
}
