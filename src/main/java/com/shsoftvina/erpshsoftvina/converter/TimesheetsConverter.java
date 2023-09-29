package com.shsoftvina.erpshsoftvina.converter;

import com.shsoftvina.erpshsoftvina.constant.TimesheetsConstant;
import com.shsoftvina.erpshsoftvina.entity.Timesheets;
import com.shsoftvina.erpshsoftvina.model.response.timesheets.TimesheetsResponse;
import com.shsoftvina.erpshsoftvina.utils.DateUtils;
import org.springframework.stereotype.Component;

import java.sql.Time;

@Component
public class TimesheetsConverter {
    public TimesheetsResponse toResponse(Timesheets timesheets) {

        Time checkin = timesheets.getCheckin();
        Time checkout = timesheets.getCheckout();

        if(checkin.compareTo(checkin) > 0) return null;

        // setup totalOfficeHours
        Time startOfficialCalculated = checkin.compareTo(TimesheetsConstant.OFFICAL_START_WORK) < 0 ? TimesheetsConstant.OFFICAL_START_WORK: checkin;
        Time endOfficialCalculated = checkout.compareTo(TimesheetsConstant.OFFICAL_FINISH_WORK)  > 0 ? TimesheetsConstant.OFFICAL_FINISH_WORK: checkout;
        String totalOfficeHours = DateUtils.timeWork(startOfficialCalculated, endOfficialCalculated);

        // setup otHours
        String otHours = null;
        if(timesheets.isOt() && checkout.compareTo(TimesheetsConstant.OFFICAL_START_OT) > 0){
            otHours = DateUtils.timeWork(TimesheetsConstant.OFFICAL_START_OT, timesheets.getCheckout());
        }

        return TimesheetsResponse.builder()
                .id(timesheets.getId())
                .workDate(DateUtils.formatDate(timesheets.getWorkDate()))
                .usernameUser(timesheets.getUser().getUsername())
                .fullnameUser(timesheets.getUser().getFullname())
                .checkin(DateUtils.formatTime(timesheets.getCheckin()))
                .checkout(DateUtils.formatTime(timesheets.getCheckout()))
                .totalOfficeHours(totalOfficeHours)
                .otHours(otHours)
                .ot(timesheets.isOt())
                .build();
    }
}