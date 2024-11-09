package com.hieDev.minierp.converter;

import com.hieDev.minierp.entity.Timesheets;
import com.hieDev.minierp.model.response.timesheets.TimesheetsResponse;
import com.hieDev.minierp.utils.DateUtils;
import org.springframework.stereotype.Component;

@Component
public class TimesheetsConverter {
    public TimesheetsResponse toResponse(Timesheets timesheets) {

        return TimesheetsResponse.builder()
                .id(timesheets.getId())
                .workDate(DateUtils.formatDate(timesheets.getWorkDate()))
                .content(timesheets.getCheckin() + "-" + timesheets.getCheckout())
                .timesheetsCode(timesheets.getTimesheetsCode())
                .build();
    }
}