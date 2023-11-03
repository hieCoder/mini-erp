package com.shsoftvina.erpshsoftvina.model.response.weeklyReport;

import com.shsoftvina.erpshsoftvina.model.response.user.IdAndFullnameUserResponse;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class WeeklyReportDetailResponse {
    private String id;
    private String title;
    private String currentWeeklyContent;
    private String nextWeeklyContent;
    private String createdDate;
    private IdAndFullnameUserResponse user;
}
