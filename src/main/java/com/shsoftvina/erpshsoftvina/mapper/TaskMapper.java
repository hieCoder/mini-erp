package com.shsoftvina.erpshsoftvina.mapper;

import com.shsoftvina.erpshsoftvina.entity.Task;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.RowBounds;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

@Mapper
public interface TaskMapper {

    List<Task> findAll(@Param("statusTask") String statusTask,
                       @Param("search") String search,
                       RowBounds rowBounds);
    long getTotalItem(@Param("statusTask") String statusTask,
                      @Param("search") String search);
    int registerTask(Task task);
    int updateTask(Task task);
    int changeStatusTask(@Param("id") String id,
                         @Param("status") String status);
    List<Map<String, Object>> getStatusTaskCounts();
    Task findById(String id);
    List<Map<String, Object>> getTaskByHashtag(@Param("userId") String userId,
                                               @Param("hashtag") String hashtag);
    int changeStatusTasks(@Param("ids") String[] ids,
                          @Param("status") String status);

    List<Task> getOpenedTask(@Param("userId") String userId);
    List<Map<String, Object>> getOpenedStatusTaskCounts(@Param("userId") String userId);

}