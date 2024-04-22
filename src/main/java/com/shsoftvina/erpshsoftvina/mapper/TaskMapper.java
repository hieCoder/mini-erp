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

    List<Task> findAll( String statusTask,
                        String search,
                       RowBounds rowBounds);
    long getTotalItem( String statusTask,
                       String search);
    int registerTask(Task task);
    int updateTask(Task task);
    int changeStatusTask( String id,
                          String status);
    List<Map<String, Object>> getStatusTaskCounts();
    Task findById(String id);
    List<Map<String, Object>> getTaskByTitle(@Param("userId") String userId,
                                               @Param("title") String title);
    int changeStatusTasks(@Param("ids") String[] ids,
                          @Param("status") String status);
    List<Task> getOpenedTask( String userId);
    List<Map<String, Object>> getOpenedStatusTaskCounts( String userId);
    List<Map<String, Object>> findAllTitle();
}