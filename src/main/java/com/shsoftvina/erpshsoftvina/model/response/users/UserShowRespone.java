package com.shsoftvina.erpshsoftvina.model.response.users;

import com.shsoftvina.erpshsoftvina.enums.user.DepartmentEnum;
import com.shsoftvina.erpshsoftvina.enums.user.PositionEnum;
import com.shsoftvina.erpshsoftvina.model.dto.EnumDto;
import lombok.*;
import lombok.experimental.SuperBuilder;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class UserShowRespone {

    private String id;
    private String fullname;
    private EnumDto department;
    private String email; // user_id
    private EnumDto position;
}
