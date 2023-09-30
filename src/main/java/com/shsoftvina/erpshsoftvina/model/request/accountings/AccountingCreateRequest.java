package com.shsoftvina.erpshsoftvina.model.request.accountings;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.web.multipart.MultipartFile;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class AccountingCreateRequest {
    private String id;
    private Long expense;
    private Long remain;
    private String userId;
    private MultipartFile bill;
    private String title;
}

