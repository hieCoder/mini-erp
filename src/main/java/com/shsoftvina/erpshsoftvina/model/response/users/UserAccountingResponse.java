package com.shsoftvina.erpshsoftvina.model.response.users;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class UserAccountingResponse {
    private String id;
    private String fullname;
}

