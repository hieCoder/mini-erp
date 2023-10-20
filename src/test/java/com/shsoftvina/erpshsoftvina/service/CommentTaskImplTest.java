package com.shsoftvina.erpshsoftvina.service;
import com.shsoftvina.erpshsoftvina.constant.CommentTaskConstant;
import com.shsoftvina.erpshsoftvina.constant.SettingConstant;
import com.shsoftvina.erpshsoftvina.converter.CommentTaskConverter;
import com.shsoftvina.erpshsoftvina.entity.CommentTask;
import com.shsoftvina.erpshsoftvina.entity.Setting;
import com.shsoftvina.erpshsoftvina.entity.Task;
import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.mapper.CommentTaskMapper;
import com.shsoftvina.erpshsoftvina.mapper.SettingMapper;
import com.shsoftvina.erpshsoftvina.mapper.TaskMapper;
import com.shsoftvina.erpshsoftvina.mapper.UserMapper;
import com.shsoftvina.erpshsoftvina.model.request.commenttask.CreateCommentTaskRequest;
import com.shsoftvina.erpshsoftvina.model.request.commenttask.UpdateCommentTaskRequest;
import com.shsoftvina.erpshsoftvina.model.response.commenttask.CommentTaskResponse;
import com.shsoftvina.erpshsoftvina.service.impl.CommentTaskImpl;
import com.shsoftvina.erpshsoftvina.utils.ApplicationUtils;
import com.shsoftvina.erpshsoftvina.utils.FileUtils;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.MockitoAnnotations;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.mock.web.MockHttpServletRequest;

import javax.servlet.http.HttpServletRequest;

import static org.hibernate.validator.internal.util.Contracts.assertNotNull;
import static org.mockito.ArgumentMatchers.any;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;

public class CommentTaskImplTest {

    @InjectMocks
    private CommentTaskImpl commentTaskService;

    @Mock
    private CommentTaskMapper commentTaskMapper;

    @Mock
    private CommentTaskConverter commentTaskConverter;

    @Mock
    private HttpServletRequest request;

    @Mock
    private TaskMapper taskMapper;

    @Mock
    private UserMapper userMapper;

    @Mock
    private ApplicationUtils applicationUtils;

    @Mock
    private SettingMapper settingMapper;

    @BeforeEach
    public void init() {
        MockitoAnnotations.initMocks(this);
    }

    @Test
    public void testFindById() {
        String commentId = "sampleCommentId";
        CommentTask commentTask = new CommentTask();
        CommentTaskResponse expectedResponse = new CommentTaskResponse();

        when(commentTaskMapper.findById(commentId)).thenReturn(commentTask);
        when(commentTaskConverter.toResponse(commentTask)).thenReturn(expectedResponse);

        CommentTaskResponse response = commentTaskService.findById(commentId);

        assertEquals(expectedResponse, response);
    }

}
