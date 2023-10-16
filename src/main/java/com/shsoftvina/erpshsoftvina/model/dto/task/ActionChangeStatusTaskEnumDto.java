package com.shsoftvina.erpshsoftvina.model.dto.task;

import com.shsoftvina.erpshsoftvina.model.dto.EnumDto;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ActionChangeStatusTaskEnumDto {
    private String code;
    private String name;
    private EnumDto[] actions;
}
