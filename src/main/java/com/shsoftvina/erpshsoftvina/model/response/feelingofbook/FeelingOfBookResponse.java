package com.shsoftvina.erpshsoftvina.model.response.feelingofbook;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class FeelingOfBookResponse {

    private String id;
    private String feeling;
    private String quote;
    private String lesson;
    private String action;
    private String createdDate;
    private String fullnameUser;
    private String avatarUser;
    private String idUser;
}