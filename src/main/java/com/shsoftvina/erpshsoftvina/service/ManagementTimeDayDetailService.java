package com.shsoftvina.erpshsoftvina.service;


import com.shsoftvina.erpshsoftvina.model.request.managementtime.daydetail.DayDetailCreateRequest;
import com.shsoftvina.erpshsoftvina.model.request.managementtime.daydetail.DayDetailUpdateRequest;
import com.shsoftvina.erpshsoftvina.model.response.managementtimedetail.DayDetailResponse;

public interface ManagementTimeDayDetailService {
    int createTimeDayDetail(DayDetailCreateRequest dayDetailCreateRequest);
    int updateTimeDayDetail(DayDetailUpdateRequest dayDetailUpdateRequest);
    DayDetailResponse findByManagementTimeDayId(String id, String code);
    boolean findByManagementTimeDayId(String id);
}
