package com.shsoftvina.erpshsoftvina.model.response.todo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class TodoManagementBoardResponse {
    List<ManagementTimeResponse> managementTimeList;
}
