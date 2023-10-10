package com.shsoftvina.erpshsoftvina.service;

import com.shsoftvina.erpshsoftvina.model.request.todo.TodoManagementEditListRequest;
import com.shsoftvina.erpshsoftvina.model.request.todo.TodoManagementListRequest;
import com.shsoftvina.erpshsoftvina.model.response.todo.TodoManagementBoardResponse;

import java.util.Date;

public interface TodoManagementService {

    TodoManagementBoardResponse findTotalElementPerMonth(String id, Date date);

    void postTodoListByUser(TodoManagementListRequest todoManagementListRequest);

    void editTodoListByUser(TodoManagementEditListRequest todoManagementListRequest);
}
