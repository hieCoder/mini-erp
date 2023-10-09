package com.shsoftvina.erpshsoftvina.model.request.todo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class TodoManagementListRequest {
    private List<TodoManagementTimeRequest> todos;
}
