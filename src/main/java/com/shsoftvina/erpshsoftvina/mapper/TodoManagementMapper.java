package com.shsoftvina.erpshsoftvina.mapper;

import com.shsoftvina.erpshsoftvina.entity.CategoryManagementTime;
import com.shsoftvina.erpshsoftvina.entity.ManagementTime;
import com.shsoftvina.erpshsoftvina.entity.TodoManagementTime;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

@Mapper
public interface TodoManagementMapper {
    List<ManagementTime> findTotalElementPerMonth(@Param("userId") String userId,@Param("date") Date date);

    CategoryManagementTime findCategoryManagementTimeByCode(String codeCategory);

    ManagementTime findManagementTimeByCode(String codeManagement);

    void savePostTodoList(List<TodoManagementTime> todoList);

    void updatePostTodoList(List<TodoManagementTime> todoList);
}
