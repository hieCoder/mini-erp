package com.shsoftvina.erpshsoftvina.model.response.timesheets;

import com.shsoftvina.erpshsoftvina.entity.User;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class TimesheetsResponse{

    private String id;
    private Date work_date;
    private Date checkin;
    private Date checkout;
    private String emailUser;
    private String fullnameUser;
    private Date totalOfficeHours;
    private Date otHours;
}