package com.shsoftvina.erpshsoftvina.model.request.user;

import com.shsoftvina.erpshsoftvina.enums.user.RoleEnum;
import com.shsoftvina.erpshsoftvina.enums.user.StatusUserEnum;
import com.shsoftvina.erpshsoftvina.enums.user.TypeUserEnum;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.web.multipart.MultipartFile;

import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserUpdateRequest {
    private String id;
    private String fullname;
    private String dateOfBirth;
    private String phone;
    private String emergencyPhone;
    private MultipartFile avatar;
    private TypeUserEnum type;
    private String department;
    private Date jobStartDate;
    private MultipartFile[] contract;
    private Long basicSalary;
    private Long allowance;
    private String insurance;
    private String atm;
    private String email;
    private RoleEnum role;
    private StatusUserEnum status;
    private String password;
}
