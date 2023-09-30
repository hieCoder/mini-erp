package com.shsoftvina.erpshsoftvina.model.request.user;


import com.shsoftvina.erpshsoftvina.enums.user.RoleEnum;
import com.shsoftvina.erpshsoftvina.enums.user.StatusUserEnum;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserActiveRequest {

    @NotBlank(message = "id is not null or empty")
    private String id;
    @NotBlank(message = "email is not null or empty")
    @Email(message = "email has incorrect syntax")
    private String email;
    @NotBlank(message = "role is not null or empty")
    private String role;
    @NotBlank(message = "status is not null or empty")
    private String status;
}
