package com.hieDev.minierp.model.request.accountings;

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

    private Long expense;

    private String userId;

    private MultipartFile[] bill;

    private String title;

    private String note;

    private String payDate;
}

