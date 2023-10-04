package com.shsoftvina.erpshsoftvina.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class TodoManagementTime {
    private String id;
    private Date day;
    private String target;
    private Boolean performance;
    private User user;
    private CategoryManagementTime category;
    private ManagementTime management;
}
