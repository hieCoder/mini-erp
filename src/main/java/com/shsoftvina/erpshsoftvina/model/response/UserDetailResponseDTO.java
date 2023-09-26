package com.shsoftvina.erpshsoftvina.model.response;

import com.shsoftvina.erpshsoftvina.enums.RoleEnum;
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
public class UserDetailResponseDTO {
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
    private String email; // user_id
    private RoleEnum role;
    private String status;
}
