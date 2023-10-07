package com.shsoftvina.erpshsoftvina.model.request.weeklyreport;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotBlank;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CreateWeeklyReportRequest {

    @NotBlank(message = "Field title is not filled")
    private String title;

    @NotBlank(message = "Field content is not filled")
    private String content;

    @NotBlank(message = "Field userId is not filled")
    private String userId;
}
