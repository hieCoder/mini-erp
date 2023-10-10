package com.shsoftvina.erpshsoftvina.model.response.todo;

import com.shsoftvina.erpshsoftvina.model.response.user.UserAccountingResponse;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class TodoManagementTimeResponse {
    private String id;
    private String day;
    private String target;
    private Boolean performance;
    private UserAccountingResponse user;
}
