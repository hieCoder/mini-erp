package com.shsoftvina.erpshsoftvina.model.request.user;



import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserRegisterRequest {
    private String email;
    private String password;
    private String confirmPassword;
}
