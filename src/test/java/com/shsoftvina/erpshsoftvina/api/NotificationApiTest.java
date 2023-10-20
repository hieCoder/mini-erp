package com.shsoftvina.erpshsoftvina.api;

import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.model.response.notification.NotificationShowResponse;
import com.shsoftvina.erpshsoftvina.service.NotificationService;
import org.junit.Before;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Mockito;

import java.util.ArrayList;
import java.util.List;

import static org.mockito.Mockito.when;

public class NotificationApiTest {
    @InjectMocks
    private NotificationApi Notification;

    @Mock
    private NotificationService notificationService;

    @Before
    public void setup() {
        // Khởi tạo giả lập dịch vụ NotificationService
        notificationService = Mockito.mock(NotificationService.class);

        // Giả lập hành vi của dịch vụ, ví dụ: khi gọi getAllNoti
        List<NotificationShowResponse> mockNotifications = new ArrayList<>();

        // Tạo các đối tượng NotificationShowResponse giả lập và thêm vào danh sách
        NotificationShowResponse notification1 = new NotificationShowResponse();
        notification1.setId("1");
        notification1.setContent("Notification content 1");
        notification1.setTitle("Notification 1");
        notification1.setFiles(new String[] {"file1.pdf", "file2.pdf"});
        notification1.setCreatedDate("2023-10-15");
        notification1.setUser(new User());

        mockNotifications.add(notification1);

        NotificationShowResponse notification2 = new NotificationShowResponse();
        notification2.setId("2");
        notification2.setContent("Notification content 2");
        notification2.setTitle("Notification 2");
        notification2.setFiles(new String[] {"file3.pdf", "file4.pdf"});
        notification2.setCreatedDate("2023-10-16");
        notification2.setUser(new User());

        mockNotifications.add(notification2);

        // Cấu hình giả lập cho phương thức getAllNoti
        when(notificationService.getAllNoti(0, 10, "")).thenReturn(mockNotifications);
    }
    @Test
    public void testGetAllNoti() {

    }


}