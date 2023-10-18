package com.shsoftvina.erpshsoftvina.model.request.book;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotBlank;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class BookUpdateRequest {

    @NotBlank(message = "Field id is not filled")
    private String id;

    @NotBlank(message = "Field title is not filled")
    private String title;

    @NotBlank(message = "Field author is not filled")
    private String author;

    @NotBlank(message = "Field link is not filled")
    private String link;
}
