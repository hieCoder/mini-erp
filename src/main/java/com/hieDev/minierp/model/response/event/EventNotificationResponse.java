package com.hieDev.minierp.model.response.event;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class EventNotificationResponse {
    private String id;
    private String title;
    private String createdDate;
}
