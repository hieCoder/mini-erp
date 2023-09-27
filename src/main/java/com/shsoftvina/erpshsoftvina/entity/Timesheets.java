package com.shsoftvina.erpshsoftvina.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

// Define User entity corresponding to user table in the database
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Timesheets{

    private String id;
    private Date work_date;
    private Date checkin;
    private Date checkout;
    private boolean ot;
    private User user;
}