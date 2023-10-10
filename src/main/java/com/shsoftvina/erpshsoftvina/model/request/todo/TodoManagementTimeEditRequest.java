package com.shsoftvina.erpshsoftvina.model.request.todo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class TodoManagementTimeEditRequest {
    private String id;
    private String target;
    private String userId;
    private String codeCategory;
    private String codeManagement;
    private Boolean performance;
}
