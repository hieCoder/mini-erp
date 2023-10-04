package com.shsoftvina.erpshsoftvina.service.impl;

import com.shsoftvina.erpshsoftvina.converter.TodoManagementConverter;
import com.shsoftvina.erpshsoftvina.mapper.TodoManagementMapper;
import com.shsoftvina.erpshsoftvina.model.response.todo.TodoManagementBoardResponse;
import com.shsoftvina.erpshsoftvina.service.TodoManagementService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TodoManagementServiceImpl implements TodoManagementService {
    @Autowired
    private TodoManagementMapper todoManagementMapper;
    @Autowired
    private TodoManagementConverter todoManagementConverter;
    @Override
    public TodoManagementBoardResponse findTotalElementPerMonth() {
        return todoManagementConverter.convertToResponse(todoManagementMapper.findTotalElementPerMonth());
    }
}
