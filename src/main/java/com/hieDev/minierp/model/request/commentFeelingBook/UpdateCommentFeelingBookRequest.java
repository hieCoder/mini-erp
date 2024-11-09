package com.hieDev.minierp.model.request.commentFeelingBook;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotBlank;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UpdateCommentFeelingBookRequest {

    @NotBlank(message = "Field id is not filled")
    private String id;

    @NotBlank(message = "Field content is not filled")
    private String content;
}
