package com.shsoftvina.erpshsoftvina.service.impl;

import com.shsoftvina.erpshsoftvina.converter.TimesheetsConverter;
import com.shsoftvina.erpshsoftvina.mapper.TimesheetsMapper;
import com.shsoftvina.erpshsoftvina.model.response.timesheets.TimesheetsResponse;
import com.shsoftvina.erpshsoftvina.service.TimesheetsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class TimesheetsServiceImpl implements TimesheetsService {

    @Autowired
    TimesheetsMapper timesheetsMapper;

    @Autowired
    TimesheetsConverter timesheetsConverter;

    @Override
    public List<TimesheetsResponse> findAll(int start, int pageSize) {
        return timesheetsMapper.findAll(start, pageSize).stream().map(timesheets -> timesheetsConverter.toResponse(timesheets)).collect(Collectors.toList());
    }
}
