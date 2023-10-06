package com.shsoftvina.erpshsoftvina.service;

import com.shsoftvina.erpshsoftvina.model.request.todo.TodoManagementEditListRequest;
import com.shsoftvina.erpshsoftvina.model.request.todo.TodoManagementListRequest;
import com.shsoftvina.erpshsoftvina.model.response.todo.TodoManagementBoardResponse;

public interface TodoManagementService {

    TodoManagementBoardResponse findTotalElementPerMonth(String id);

    void postTodoListByUser(TodoManagementListRequest todoManagementListRequest);

    void editTodoListByUser(TodoManagementEditListRequest todoManagementListRequest);
}
