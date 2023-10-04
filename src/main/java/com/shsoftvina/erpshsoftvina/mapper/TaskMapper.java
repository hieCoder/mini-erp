package com.shsoftvina.erpshsoftvina.mapper;

import com.shsoftvina.erpshsoftvina.entity.Task;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface TaskMapper {

    List<Task> findAll(@Param("start") int start,
                       @Param("pageSize") int pageSize,
                       @Param("status") String status,
                       @Param("search") String search);
    int registerTask(Task task);
}