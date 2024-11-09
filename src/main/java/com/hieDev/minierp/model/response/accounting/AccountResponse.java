package com.hieDev.minierp.model.response.accounting;

import com.hieDev.minierp.model.response.user.IdAndFullnameUserResponse;
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
    private String payDate;
    private Long revenue;
    private Long expense;
    private Long remain;
    private IdAndFullnameUserResponse user;
    private String[] bill;
    private String title;
    private String note;
}

