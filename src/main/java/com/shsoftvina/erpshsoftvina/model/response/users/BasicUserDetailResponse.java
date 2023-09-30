
package com.shsoftvina.erpshsoftvina.model.response.users;

import com.shsoftvina.erpshsoftvina.enums.user.*;
import lombok.*;
import lombok.experimental.SuperBuilder;

import java.util.Date;


@Data
@AllArgsConstructor
@NoArgsConstructor
@SuperBuilder
public class BasicUserDetailResponse {
    private String id;
    private String fullname;
    private String dateOfBirth;
    private String address;
    private String phone;
    private String emergencyPhone;
    private String avatar;
    private TypeUserEnum type;
    private DepartmentEnum department;
    private String[] workingday;
    private String email; // user_id
    private String password;
    private RoleEnum role;
    private StatusUserEnum status;
    private PositionEnum position;
    private String resume;
}
