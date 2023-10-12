package com.shsoftvina.erpshsoftvina.model.request.commenttask;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.constraints.NotBlank;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class UpdateCommentTaskRequest {

    @NotBlank(message = "Field id is not filled")
    private String id;

    private String title;

    private String content;

    private MultipartFile[] files;
}