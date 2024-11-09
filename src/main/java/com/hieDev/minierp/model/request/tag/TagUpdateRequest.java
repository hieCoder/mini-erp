package com.hieDev.minierp.model.request.tag;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotBlank;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class TagUpdateRequest {
    @NotBlank(message = "Field id is not filled")
    private String id;
    private String tagName;
    private String type;
}