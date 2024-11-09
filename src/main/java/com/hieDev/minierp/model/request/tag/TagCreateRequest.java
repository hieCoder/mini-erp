package com.hieDev.minierp.model.request.tag;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class TagCreateRequest {

    @NotBlank(message = "Field code is not filled")
    private String tagName;

    @NotBlank(message = "Field code is not filled")
    private String type;
}