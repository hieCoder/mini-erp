package com.shsoftvina.erpshsoftvina.model.request.task;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class TaskUpdateRequest {

    @NotBlank(message = "Field id is not filled")
    private String id;

    private String action;

    @NotBlank(message = "Field title is not filled")
    private String title;

    @NotBlank(message = "Field priority is not filled")
    private String priority;

    @Min(value = 0, message = "Field progress must > 0")
    private Integer progress;

    @NotBlank(message = "Field content is not filled")
    private String content;
}
