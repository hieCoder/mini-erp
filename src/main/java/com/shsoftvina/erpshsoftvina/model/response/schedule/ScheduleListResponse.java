package com.shsoftvina.erpshsoftvina.model.response.schedule;

import com.shsoftvina.erpshsoftvina.model.response.task.TaskShowResponse;
import com.shsoftvina.erpshsoftvina.model.response.user.UserAccountingResponse;
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
    private List<TaskShowResponse> list;
    private UserAccountingResponse user;
}
