package com.shsoftvina.erpshsoftvina.model.response.users;

import com.shsoftvina.erpshsoftvina.enums.RoleEnum;
import com.shsoftvina.erpshsoftvina.enums.StatusUserEnum;
import com.shsoftvina.erpshsoftvina.enums.TypeUserEnum;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class UserDetailResponse {
    private String id;
    private String fullname;
    private String dateOfBirth;
    private String phone;
    private String emergencyPhone;
    private String avatar;
    private TypeUserEnum type;
    private String department;
    private Date jobStartDate;
    private String contract;
    private Long basicSalary;
    private Long allowance;
    private String insurance;
    private String atm;
    private String username;
    private String email; // user_id
    private RoleEnum role;
    private StatusUserEnum status;
}
