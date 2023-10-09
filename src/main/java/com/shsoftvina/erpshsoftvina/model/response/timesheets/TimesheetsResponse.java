package com.shsoftvina.erpshsoftvina.model.response.timesheets;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class TimesheetsResponse{

    private String id;
    private String workDate;
    private String checkin;
    private String checkout;
    private String fullnameUser;
    private String totalOfficeHours;
    private boolean ot;
    private String otHours;
}