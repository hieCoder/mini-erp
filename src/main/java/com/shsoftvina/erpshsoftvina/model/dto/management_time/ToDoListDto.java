package com.shsoftvina.erpshsoftvina.model.dto.management_time;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ToDoListDto {
    private ItemDto[] sixToTwelvePm;
    private ItemDto[] twelveToSixPm;
    private ItemDto[] sixToTwelveAm;
}
