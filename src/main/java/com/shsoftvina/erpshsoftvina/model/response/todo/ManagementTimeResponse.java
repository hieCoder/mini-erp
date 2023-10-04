package com.shsoftvina.erpshsoftvina.model.response.todo;

import com.shsoftvina.erpshsoftvina.entity.CategoryManagementTime;
import com.shsoftvina.erpshsoftvina.entity.TodoManagementTime;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ManagementTimeResponse {
    private String id;
    private String value;
    private List<CategoryManagementTimeResponse> categories;
    private List<TodoManagementTimeResponse> todos;
}
