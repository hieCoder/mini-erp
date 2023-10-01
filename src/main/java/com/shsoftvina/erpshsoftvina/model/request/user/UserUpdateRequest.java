package com.shsoftvina.erpshsoftvina.model.request.user;

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

    @NotBlank(message = "Field fullname is not filled")
    private String fullname;

    @NotBlank(message = "Field address is not filled")
    private String address;

    @NotBlank(message = "Field dateOfBirth is not filled")
    private Date dateOfBirth;

    @NotBlank(message = "Field phone is not filled")
    private String phone;

    @NotBlank(message = "Field emergencyPhone is not filled")
    private String emergencyPhone;

    private MultipartFile avatar;

    @NotBlank(message = "Field type is not filled")
    private String type;

    @NotBlank(message = "Field department is not filled")
    private String department;
    private Date workingDay;
    private MultipartFile[] contract;
    private Long basicSalary;
    private Long allowance;
    private String insurance;
    private String atm;

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

    @NotBlank(message = "Field position is not filled")
    private String position;

    private MultipartFile resume;
    private String timesheetsCode;
}