package com.shsoftvina.erpshsoftvina.entity;

import lombok.*;

import java.sql.Time;
import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Timesheets{

    private String id;
    private Date workDate;
    private String checkin;
    private String checkout;
    private String timesheetsCode;
}