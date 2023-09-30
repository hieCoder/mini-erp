package com.shsoftvina.erpshsoftvina.model.response.users;

import com.shsoftvina.erpshsoftvina.enums.user.DepartmentEnum;
import com.shsoftvina.erpshsoftvina.enums.user.PositionEnum;
import lombok.*;
import lombok.experimental.SuperBuilder;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ShowUserRespone {

    private String id;
    private String fullname;
    private DepartmentEnum department;
    private String email; // user_id
    private PositionEnum position;

}
