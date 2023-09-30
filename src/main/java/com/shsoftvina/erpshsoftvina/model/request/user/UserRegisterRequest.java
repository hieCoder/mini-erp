package com.shsoftvina.erpshsoftvina.model.request.user;



import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.Email;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserRegisterRequest {

    @NotBlank(message = "fullname is not null or empty")
    private String fullname;

    @NotBlank(message = "email is not null or empty")
    @Email(message = "email has incorrect syntax")
    private String email;

    @NotBlank(message = "password is not null or empty")
    @Min(6)
    private String password;

    @NotBlank(message = "confirmPassword is not null or empty")
    @Min(6)
    private String confirmPassword;
}
