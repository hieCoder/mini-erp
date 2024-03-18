package com.shsoftvina.erpshsoftvina.model.request.feelingofbook;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotBlank;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class FeelingOfBookCreateRequest {

    @NotBlank(message = "Field userId is not filled")
    private String userId;

    private String bookReport;
    private Double timeSpentReading;
    private String note;

    @NotBlank(message = "Field bookId is not filled")
    private String bookId;
}
