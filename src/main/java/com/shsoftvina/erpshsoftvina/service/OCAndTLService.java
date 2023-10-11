package com.shsoftvina.erpshsoftvina.service;

import com.shsoftvina.erpshsoftvina.model.response.oc_and_tl.OCAndTLOfOneDayResponse;

import java.util.List;

public interface OCAndTLService {
    List<OCAndTLOfOneDayResponse> getAllByUserId(String userId);
}
