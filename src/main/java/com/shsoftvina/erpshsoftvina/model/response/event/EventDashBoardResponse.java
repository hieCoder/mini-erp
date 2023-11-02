package com.shsoftvina.erpshsoftvina.model.response.event;

import com.shsoftvina.erpshsoftvina.model.dto.EnumDto;
import com.shsoftvina.erpshsoftvina.model.response.user.FullnameAndAvatarResponse;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class EventDashBoardResponse {
    private String id;
    private String startDate;
    private String endDate;
    private String title;
    private String content;
    private FullnameAndAvatarResponse user;
    private EnumDto type;
}
