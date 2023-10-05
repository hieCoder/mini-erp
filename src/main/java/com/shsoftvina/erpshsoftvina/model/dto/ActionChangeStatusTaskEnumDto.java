package com.shsoftvina.erpshsoftvina.model.dto;

import com.shsoftvina.erpshsoftvina.enums.task.ActionChangeStatusTaskEnum;
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
