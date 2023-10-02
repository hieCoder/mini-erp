
package com.shsoftvina.erpshsoftvina.model.response.users;

import com.shsoftvina.erpshsoftvina.enums.user.*;
import com.shsoftvina.erpshsoftvina.model.dto.EnumDto;
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
    private EnumDto type;
    private EnumDto department;
    private String[] workingday;
    private String email; // user_id
    private EnumDto role;
    private EnumDto position;
    private String resume;
    private String atm;
    private String timesheetsCode;
}
