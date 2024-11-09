package com.hieDev.minierp.model.request.feelingofbook;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotBlank;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class FeelingOfBookUpdateRequest {

    @NotBlank(message = "Field id is not filled")
    private String userId;
    @NotBlank(message = "Field bookId is not filled")
    private String bookId;

    private String bookReport;
    private Double timeSpentReading;
    private String note;
}
