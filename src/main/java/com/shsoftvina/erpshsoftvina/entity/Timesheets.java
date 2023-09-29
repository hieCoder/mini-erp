package com.shsoftvina.erpshsoftvina.entity;

import lombok.*;

import java.sql.Time;
import java.util.Date;

// Define User entity corresponding to user table in the database
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Timesheets{

    private String id;
    private Date workDate;
    private Time checkin;
    private Time checkout;
    private boolean ot;
    private User user;
}