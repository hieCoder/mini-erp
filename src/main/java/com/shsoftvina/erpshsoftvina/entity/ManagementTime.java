package com.shsoftvina.erpshsoftvina.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ManagementTime {
    private String id;
    private String code;
    private String value;
    private List<CategoryManagementTime> categories;
    private List<TodoManagementTime> todos;
}
