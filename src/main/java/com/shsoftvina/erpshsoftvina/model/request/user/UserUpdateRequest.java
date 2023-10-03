package com.shsoftvina.erpshsoftvina.model.request.user;

import com.shsoftvina.erpshsoftvina.enums.user.RoleEnum;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;
import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserUpdateRequest {

    private String id;

    private String fullname;

    private Date dateOfBirth;

    private String phone;

    private String emergencyPhone;

    private MultipartFile avatar;

    private String type;

    private String department;
    private String atm;

    private String email;

    @Size(min = 6, message = "Password must have at least 6 characters and include Letters, numbers and special characters")
    @Pattern(
            regexp = "^(?=.*[a-zA-Z])(?=.*\\d)(?=.*[@#$%^&+=!]).*$",
            message = "Password must have at least 6 characters and include Letters, numbers and special characters"
    )
    private String password;

    private String role;

    private String status;

    private String position;

    private MultipartFile resume;

    private String address;

    private boolean isFirstUpdateProfile;

    private String timesheetsCode;

}