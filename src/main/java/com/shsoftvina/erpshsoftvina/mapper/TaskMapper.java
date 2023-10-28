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
                       @Param("statusTask") String statusTask,
                       @Param("search") String search);
    long getTotalItem(@Param("start") int start,
                      @Param("pageSize") int pageSize,
                      @Param("statusTask") String statusTask,
                      @Param("search") String search);
    int registerTask(Task task);
    int updateTask(Task task);
    int changeStatusTask(@Param("id") String id,
                         @Param("status") String status);
    List<Map<String, Object>> getStatusTaskCounts();
    Task findById(String id);
    List<Map<String, Object>> getTaskByHashtag(
            @Param("userId") String userId);
}