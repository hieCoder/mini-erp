package com.shsoftvina.erpshsoftvina.model.response.accountings;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;
import java.time.LocalDateTime;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class AccountResponse {
    private String id;
    private String createdDate;
    private Integer revenue;
    private Integer expense;
    private Integer remain;
    private String username;
    private String bill;
}
