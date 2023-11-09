package com.shsoftvina.erpshsoftvina.model.request.book;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class BookCreateRequest {

    @NotBlank(message = "Field title is not filled")
    private String title;

    @NotBlank(message = "Field author is not filled")
    private String author;

    @NotBlank(message = "Field link is not filled")
    private String link;

    @NotBlank(message = "Field fullnameUser is not filled")
    private String fullnameUser;

    @NotNull(message = "Field image is not filled")
    private MultipartFile image;
}
