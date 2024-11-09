package com.hieDev.minierp.model.response.schedule;

import com.hieDev.minierp.model.dto.EnumDto;
import com.hieDev.minierp.model.response.user.IdAndFullnameUserResponse;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ScheduleListResponse {
    private List<TaskResponse> list;
    private IdAndFullnameUserResponse user;

    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    @Builder
    public static class TaskResponse{
        private String id;
        private String title;
        private String startDate;
        private String dueOrCloseDate;
        private EnumDto statusTask;
    }
}