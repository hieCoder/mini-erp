package com.hieDev.minierp.model.request.task;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.constraints.NotBlank;
import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class TaskRegisterRequest {

    @NotBlank(message = "Field title is not filled")
    private String title;

    @NotBlank(message = "Field content is not filled")
    private String content;

    @NotBlank(message = "Field userId is not filled")
    private String userId;

    @NotBlank(message = "Field priority is not filled")
    private String priority;

    private Date dueDate;
    private String tag;
    private String pic;
    private String relatedTask;
    private MultipartFile[] filesTask;
}
