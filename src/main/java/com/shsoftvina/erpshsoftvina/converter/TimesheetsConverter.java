package com.shsoftvina.erpshsoftvina.converter;

import com.shsoftvina.erpshsoftvina.entity.Timesheets;
import com.shsoftvina.erpshsoftvina.model.response.timesheets.TimesheetsResponse;
import com.shsoftvina.erpshsoftvina.utils.DateUtils;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class TimesheetsConverter {
    public TimesheetsResponse toResponse(Timesheets timesheets) {

        return TimesheetsResponse.builder()
                .id(timesheets.getId())
                .workDate(DateUtils.formatDate(timesheets.getWorkDate()))
                .content(timesheets.getContent())
                .timesheetsCode(timesheets.getTimesheetsCode())
                .build();
    }
}