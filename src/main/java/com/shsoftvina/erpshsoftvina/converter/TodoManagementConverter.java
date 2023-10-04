package com.shsoftvina.erpshsoftvina.converter;

import com.shsoftvina.erpshsoftvina.entity.CategoryManagementTime;
import com.shsoftvina.erpshsoftvina.entity.ManagementTime;
import com.shsoftvina.erpshsoftvina.entity.TodoManagementTime;
import com.shsoftvina.erpshsoftvina.model.response.todo.CategoryManagementTimeResponse;
import com.shsoftvina.erpshsoftvina.model.response.todo.ManagementTimeResponse;
import com.shsoftvina.erpshsoftvina.model.response.todo.TodoManagementBoardResponse;
import com.shsoftvina.erpshsoftvina.model.response.todo.TodoManagementTimeResponse;
import com.shsoftvina.erpshsoftvina.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.stream.Collectors;

@Component
public class TodoManagementConverter {
    @Autowired
    private UserConverter userConverter;
    public TodoManagementBoardResponse convertToResponse(List<ManagementTime> managementTimeList) {
        return TodoManagementBoardResponse.builder()
                .managementTimeList(convertToList(managementTimeList))
                .build();
    }

    public ManagementTimeResponse convertToResponse(ManagementTime managementTime) {
        return ManagementTimeResponse.builder()
                .todos(convertToTodoListResponse(managementTime.getTodos()))
                .categories(convertToListResponse(managementTime.getCategories()))
                .id(managementTime.getId())
                .value(managementTime.getValue())
                .build();
    }

    public List<ManagementTimeResponse> convertToList(List<ManagementTime> managementTimes) {
        return managementTimes.stream().map(this::convertToResponse).collect(Collectors.toList());
    }

    public TodoManagementTimeResponse convertToResponse (TodoManagementTime time) {
        return TodoManagementTimeResponse.builder()
                .id(time.getId())
                .day(DateUtils.formatDate(time.getDay()))
                .performance(time.getPerformance())
                .target(time.getTarget())
                .user(userConverter.toAccountResponse(time.getUser()))
                .build();
    }
    public List<TodoManagementTimeResponse> convertToTodoListResponse(List<TodoManagementTime> list) {
        if (list == null) {
            return null;
        }
        return list.stream().map(this::convertToResponse).collect(Collectors.toList());
    }

    public CategoryManagementTimeResponse convertToResponse(CategoryManagementTime category) {
        return CategoryManagementTimeResponse.builder()
                .todos(convertToTodoListResponse(category.getTodos()))
                .id(category.getId())
                .value(category.getValue())
                .build();
    }

    public List<CategoryManagementTimeResponse> convertToListResponse(List<CategoryManagementTime> categoryList) {
        return categoryList.stream().map(this::convertToResponse).collect(Collectors.toList());
    }
}
