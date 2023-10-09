package com.shsoftvina.erpshsoftvina.service.impl;

import com.shsoftvina.erpshsoftvina.converter.TodoManagementConverter;
import com.shsoftvina.erpshsoftvina.entity.CategoryManagementTime;
import com.shsoftvina.erpshsoftvina.entity.ManagementTime;
import com.shsoftvina.erpshsoftvina.entity.TodoManagementTime;
import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.mapper.TodoManagementMapper;
import com.shsoftvina.erpshsoftvina.mapper.UserMapper;
import com.shsoftvina.erpshsoftvina.model.request.todo.TodoManagementEditListRequest;
import com.shsoftvina.erpshsoftvina.model.request.todo.TodoManagementListRequest;
import com.shsoftvina.erpshsoftvina.model.request.todo.TodoManagementTimeEditRequest;
import com.shsoftvina.erpshsoftvina.model.request.todo.TodoManagementTimeRequest;
import com.shsoftvina.erpshsoftvina.model.response.todo.TodoManagementBoardResponse;
import com.shsoftvina.erpshsoftvina.service.TodoManagementService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service
public class TodoManagementServiceImpl implements TodoManagementService {
    @Autowired
    private TodoManagementMapper todoManagementMapper;
    @Autowired
    private UserMapper userMapper;
    @Autowired
    private TodoManagementConverter todoManagementConverter;
    @Override
    public TodoManagementBoardResponse findTotalElementPerMonth(String id, Date date) {
        return todoManagementConverter.convertToResponse(todoManagementMapper.findTotalElementPerMonth(id,date));
    }

    @Override
    public void postTodoListByUser(TodoManagementListRequest todoManagementListRequest) {
        List<TodoManagementTime> todoList = new ArrayList<>();
        for (TodoManagementTimeRequest request : todoManagementListRequest.getTodos()) {
            CategoryManagementTime category = todoManagementMapper.findCategoryManagementTimeByCode(request.getCodeCategory());
            ManagementTime management = todoManagementMapper.findManagementTimeByCode(request.getCodeManagement());
            User user = userMapper.findById(request.getUserId());
            TodoManagementTime todo = todoManagementConverter.convertToEntity(request,category,management,user);
            todoList.add(todo);
        }
        todoManagementMapper.savePostTodoList(todoList);
    }

    @Override
    public void editTodoListByUser(TodoManagementEditListRequest todoManagementListRequest) {
        List<TodoManagementTime> todoList = new ArrayList<>();
        for (TodoManagementTimeEditRequest request : todoManagementListRequest.getTodos()) {
            CategoryManagementTime category = todoManagementMapper.findCategoryManagementTimeByCode(request.getCodeCategory());
            ManagementTime management = todoManagementMapper.findManagementTimeByCode(request.getCodeManagement());
            User user = userMapper.findById(request.getUserId());
            TodoManagementTime todo = todoManagementConverter.convertToEntity(request,category,management,user);
            todoList.add(todo);
        }
        todoManagementMapper.updatePostTodoList(todoList);
    }
}
