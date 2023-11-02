package com.shsoftvina.erpshsoftvina.model.response.user;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class FullnameAndAvatarResponse {
    private String id;
    private String fullname;
    private String avatar;
}
