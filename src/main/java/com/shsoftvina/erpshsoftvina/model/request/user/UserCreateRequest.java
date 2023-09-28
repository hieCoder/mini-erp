package com.shsoftvina.erpshsoftvina.model.request.user;



import com.shsoftvina.erpshsoftvina.enums.StatusUserEnum;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserCreateRequest {
    private String id;
    private String username;
    private String email;
    private String password;
    private String confirmPassword;
    private StatusUserEnum status;
}
