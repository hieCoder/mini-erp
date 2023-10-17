package com.shsoftvina.erpshsoftvina.model.response.accounting;

import com.shsoftvina.erpshsoftvina.model.response.user.UserAccountingResponse;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class AccountResponse {
    private String id;
    private String createdDate;
    private Long revenue;
    private Long expense;
    private Long remain;
    private UserAccountingResponse user;
    private String[] bill;
    private String title;
    private String note;
}

