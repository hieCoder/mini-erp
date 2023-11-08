package com.shsoftvina.erpshsoftvina.model.response.event;

import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.enums.event.EventTypeEnum;
import com.shsoftvina.erpshsoftvina.model.dto.EnumDto;
import com.shsoftvina.erpshsoftvina.model.response.user.IdAndFullnameUserResponse;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class EventResponse {
    private String id;
    private String startDate;
    private String endDate;
    private String title;
    private String content;
    private IdAndFullnameUserResponse user;
    private EnumDto type;
    private String categoryPush;
}
