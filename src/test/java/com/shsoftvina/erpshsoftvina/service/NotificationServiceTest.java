//package com.shsoftvina.erpshsoftvina.service;
//
//import com.shsoftvina.erpshsoftvina.constant.NotificationConstant;
//import com.shsoftvina.erpshsoftvina.converter.NotificationConverter;
//import com.shsoftvina.erpshsoftvina.entity.Notification;
//import com.shsoftvina.erpshsoftvina.mapper.NotificationMapper;
//import com.shsoftvina.erpshsoftvina.model.request.notification.CreateNotificationRequest;
//import com.shsoftvina.erpshsoftvina.model.response.notification.NotificationShowResponse;
//import com.shsoftvina.erpshsoftvina.service.NotificationService;
//import com.shsoftvina.erpshsoftvina.service.impl.NotificationImpl;
//import com.shsoftvina.erpshsoftvina.utils.ApplicationUtils;
//import com.shsoftvina.erpshsoftvina.utils.FileUtils;
//import org.junit.Before;
//import org.junit.Test;
//import org.mockito.InjectMocks;
//import org.mockito.Mock;
//import org.mockito.Mockito;
//import org.mockito.MockitoAnnotations;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.mock.web.MockHttpSession;
//import org.springframework.mock.web.MockMultipartFile;
//import org.springframework.mock.web.MockServletContext;
//import org.springframework.web.multipart.MultipartFile;
//import org.springframework.http.ResponseEntity;
//import org.springframework.test.web.servlet.request.MockHttpServletRequestBuilder;
//import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
//
//import javax.servlet.ServletContext;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpSession;
//import java.util.ArrayList;
//import java.util.Collections;
//import java.util.List;
//
//import static org.mockito.Mockito.verify;
//import static org.mockito.Mockito.when;
//import static org.junit.jupiter.api.Assertions.assertEquals;
//
//public class NotificationServiceTest {
//
//    @InjectMocks
//    private NotificationImpl notificationService;
//
//    @Mock
//    private ApplicationUtils applicationUtils;
//
//    @Mock
//    private NotificationMapper notificationMapper;
//    @Mock
//    private NotificationConverter notificationConverter;
//
//    @Mock
//    private HttpServletRequest mockHttpServletRequest;
//
//    @Before
//    public void init() {
//        MockitoAnnotations.openMocks(this);
//    }
//
//    @Test
//    public void testGetAllNoti() {
//        int start = 0;
//        int pageSize = 10;
//        String search = "search test";
//
//        List<Notification> mockNotificationList = Collections.singletonList(new Notification());
//        when(notificationMapper.getAllNoti(start, pageSize, search)).thenReturn(mockNotificationList);
//
//        List<NotificationShowResponse> mockResponseList = Collections.singletonList(new NotificationShowResponse());
//
//        when(notificationConverter.toListShowResponse(mockNotificationList)).thenReturn(mockResponseList);
//
//        List<NotificationShowResponse> result = notificationService.getAllNoti(start, pageSize, search);
//
//        assertEquals(mockResponseList, result);
//    }
//
//    @Test
//    public void testCreateNotiWithValidFiles() {
//        String path = new String();
//        HttpSession mockHttpSession = Mockito.mock(HttpSession.class);
//        HttpServletRequest mockHttpServletRequest = Mockito.mock(HttpServletRequest.class);
//        ServletContext mockServletContext = Mockito.mock(ServletContext.class);
//        when(mockHttpServletRequest.getSession()).thenReturn(mockHttpSession);
//        when(mockHttpSession.getServletContext()).thenReturn(mockServletContext);
//        when(mockServletContext.getRealPath("/")).thenReturn(path);
//
//        CreateNotificationRequest createNotificationRequest = new CreateNotificationRequest();
//        MockMultipartFile file1 = new MockMultipartFile("files", "file1.txt", "text/plain", "Hello, World!".getBytes());
//        MockMultipartFile file2 = new MockMultipartFile("files", "file2.txt", "text/plain", "Spring Testing!".getBytes());
//        MultipartFile[] files = {file1, file2};
//        createNotificationRequest.setFiles(files);
//        List<String> listFileNameSaveFileSuccess = new ArrayList<>();
//
//        applicationUtils.checkValidateFile(Notification.class, files);
//        verify(applicationUtils).checkValidateFile(Notification.class, files)
//        ;
//        listFileNameSaveFileSuccess = FileUtils.saveMultipleFilesToServer(mockHttpServletRequest, NotificationConstant.UPLOAD_FILE_DIR, files);
//        when(FileUtils.saveMultipleFilesToServer(mockHttpServletRequest, NotificationConstant.UPLOAD_FILE_DIR, files)).thenReturn(listFileNameSaveFileSuccess);
//        verify(FileUtils.saveMultipleFilesToServer(mockHttpServletRequest, NotificationConstant.UPLOAD_FILE_DIR, files));
//
//
//        Notification notification = new Notification();
//        when(notificationConverter.toEntity(createNotificationRequest, listFileNameSaveFileSuccess)).thenReturn(notification);
//        verify(notificationConverter).toEntity(createNotificationRequest, listFileNameSaveFileSuccess);
//
//        when(notificationMapper.createNoti(notification)).thenReturn(notification);
//        verify(notificationMapper).createNoti(notification);
//
//        int result = notificationService.createNoti(createNotificationRequest);
//        assertEquals(1, result);
//    }
//
//
//}
