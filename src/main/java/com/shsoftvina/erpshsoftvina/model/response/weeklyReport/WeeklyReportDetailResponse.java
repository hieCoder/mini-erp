package com.shsoftvina.erpshsoftvina.model.response.weeklyReport;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class WeeklyReportDetailResponse {
    private String id;
    private String title;
    private String content;
    private String fullnameUser;
    private String createdDate;
}
