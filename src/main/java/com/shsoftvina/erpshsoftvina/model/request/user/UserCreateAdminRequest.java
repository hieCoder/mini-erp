package com.shsoftvina.erpshsoftvina.model.request.user;

import com.shsoftvina.erpshsoftvina.enums.user.RoleEnum;
import com.shsoftvina.erpshsoftvina.enums.user.StatusUserEnum;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserCreateAdminRequest {

    @NotBlank(message = "Field UserID is not filled")
    @Email(message = "Invalid UserID")
    private String email;

    @NotBlank(message = "Field password is not filled")
    @Size(min = 6, message = "Password must have at least 6 characters and include Letters, numbers and special characters")
    @Pattern(
            regexp = "^(?=.*[a-zA-Z])(?=.*\\d)(?=.*[@#$%^&+=!]).*$",
            message = "Password must have at least 6 characters and include Letters, numbers and special characters"
    )
    private String password;

    @NotBlank(message = "Field role is not filled")
    private String role;

    private String status;

    @NotBlank(message = "Field status is not filled")
    private boolean firstUpdateProfile;

}
