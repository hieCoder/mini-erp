package com.shsoftvina.erpshsoftvina.service.impl;

import com.shsoftvina.erpshsoftvina.converter.OCAndTLConverter;
import com.shsoftvina.erpshsoftvina.mapper.OCAndTLMapper;
import com.shsoftvina.erpshsoftvina.model.response.oc_and_tl.OCAndTLOfOneDayResponse;
import com.shsoftvina.erpshsoftvina.service.OCAndTLService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OCAndTLImpl implements OCAndTLService {

    @Autowired
    private OCAndTLMapper OCAndTLMapper;

    @Autowired
    private OCAndTLConverter OCAndTLConverter;

    @Override
    public List<OCAndTLOfOneDayResponse> getAllByUserId(String userId) {
        return OCAndTLConverter.toListOCAndTLShowResponse(OCAndTLMapper.getAllByUserId(userId));
    }
}