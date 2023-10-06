package com.shsoftvina.erpshsoftvina.mapper;

import com.shsoftvina.erpshsoftvina.entity.Task;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@Mapper
public interface TaskMapper {

    List<Task> findAll(@Param("start") int start,
                       @Param("pageSize") int pageSize,
                       @Param("status") String status,
                       @Param("search") String search);
    int registerTask(Task task);
    int updateTask(Task task);
    int changeStatusTask(@Param("id") String id, @Param("status") String status);
    List<Map<String, Object>> getStatusTaskCounts();
    Task findById(String id);
}