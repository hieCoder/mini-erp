package com.shsoftvina.erpshsoftvina.model.request.commentFeelingBook;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotBlank;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CreateCommentFeelingBookRequest {

    @NotBlank(message = "Field content is not filled")
    private String content;

    @NotBlank(message = "Field feelingBookId is not filled")
    private String feelingBookId;

    @NotBlank(message = "Field parentId is not filled")
    private String parentId;

    @NotBlank(message = "Field userId is not filled")
    private String userId;
}
