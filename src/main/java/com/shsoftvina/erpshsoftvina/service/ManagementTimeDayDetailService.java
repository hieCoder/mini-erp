package com.shsoftvina.erpshsoftvina.service;


import com.shsoftvina.erpshsoftvina.model.request.managementtime.daydetail.DayDetailCreateRequest;
import com.shsoftvina.erpshsoftvina.model.request.managementtime.daydetail.DayDetailUpdateRequest;

public interface ManagementTimeDayDetailService {
    int createTimeDayDetail(DayDetailCreateRequest dayDetailCreateRequest);

    int updateTimeDayDetail(DayDetailUpdateRequest dayDetailUpdateRequest);
}
