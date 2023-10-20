package com.shsoftvina.erpshsoftvina.service;

import com.shsoftvina.erpshsoftvina.constant.AccountingConstant;
import com.shsoftvina.erpshsoftvina.converter.AccountingConverter;
import com.shsoftvina.erpshsoftvina.entity.Accounting;
import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.enums.accounting.StatusAccountingEnum;
import com.shsoftvina.erpshsoftvina.mapper.AccountingMapper;
import com.shsoftvina.erpshsoftvina.mapper.UserMapper;
import com.shsoftvina.erpshsoftvina.model.request.accountings.AccountingCreateRequest;
import com.shsoftvina.erpshsoftvina.model.request.accountings.AccountingUpdateRequest;
import com.shsoftvina.erpshsoftvina.model.response.accounting.AccountResponse;
import com.shsoftvina.erpshsoftvina.model.response.accounting.MonthHistoryList;
import com.shsoftvina.erpshsoftvina.model.response.accounting.MonthYearFormat;
import com.shsoftvina.erpshsoftvina.model.response.accounting.PageAccountListResponse;
import com.shsoftvina.erpshsoftvina.model.response.accounting.TotalSpendAndRemain;
import com.shsoftvina.erpshsoftvina.model.response.user.UserAccountingResponse;
import com.shsoftvina.erpshsoftvina.service.impl.AccountingServiceImpl;
import com.shsoftvina.erpshsoftvina.utils.ApplicationUtils;
import com.shsoftvina.erpshsoftvina.utils.DateUtils;
import com.shsoftvina.erpshsoftvina.utils.FileUtils;
import org.apache.ibatis.session.RowBounds;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.MockitoAnnotations;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyList;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.doNothing;
import static org.mockito.Mockito.doThrow;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@WebAppConfiguration
public class AccountingServiceTest {
    @Mock
    private UserMapper userMapper;

    @Mock
    private HttpServletRequest request;
    @Mock
    private FileUtils fileUtils;
    @Mock
    private ApplicationUtils applicationUtils;
    @Mock
    private AccountingMapper accountingMapper;
    private final AccountingConverter accountingConverter = mock(AccountingConverter.class);
    private MockMvc mockMvc;
    @InjectMocks
    private AccountingServiceImpl accountingService;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.initMocks(this);
        mockMvc = MockMvcBuilders.standaloneSetup(accountingService).build();
    }

    @AfterEach
    public void resetMocks() {
        Mockito.reset(accountingMapper);
    }

    @Test
    void findAllMonthlyHistory() {
        List<MonthYearFormat> monthList = new ArrayList<>();
        monthList.add(new MonthYearFormat("2023", Arrays.asList("2023-10", "2023-09", "2023-08", "2023-07")));
        monthList.add(new MonthYearFormat("2022", Arrays.asList("2022-10", "2022-09", "2022-08", "2022-07")));
        when(accountingMapper.findAllMonthlyHistory()).thenReturn(monthList);
        when(accountingConverter.convertListToObjectDTO(monthList)).thenReturn(new MonthHistoryList(monthList));
        MonthHistoryList monthListActual = accountingService.findAllMonthlyHistory();
        assertEquals(monthList, monthListActual.getMonthList());
    }

    @Test
    public void testFindAccountingByMonth() {
        // Arrange
        String monthId = "yourMonthId";
        Integer page = 1;
        Integer size = 10;
        LocalDate startTime = LocalDate.of(2023, 1, 1);
        LocalDate endTime = LocalDate.of(2023, 1, 31);
        RowBounds rowBounds = new RowBounds(10,10);

        // Create mock data for your dependencies
        TotalSpendAndRemain totals = new TotalSpendAndRemain();
        when(accountingMapper.getTotalSpending(monthId)).thenReturn(totals);
        when(accountingMapper.getLatestRemain(monthId)).thenReturn(100L);

        LocalDateTime endDateWithTime = LocalDateTime.of(2023, 1, 31, 23, 59, 59);
        List<Accounting> accountingList = new ArrayList<>(); // Mock your accounting data
        when(accountingMapper.findAccountingByMonth(eq(monthId), eq(rowBounds), eq(startTime), eq(endDateWithTime)))
                .thenReturn(accountingList);

        List<AccountResponse> accountResponses = new ArrayList<>(); // Mock your response data
        when(accountingConverter.convertToListResponse(accountingList)).thenReturn(accountResponses);

        long totalRecordCount = 50L; // Mock your total record count
        when(accountingMapper.getTotalRecordCountPerMonth(monthId, startTime, endDateWithTime)).thenReturn(totalRecordCount);

        // Act
        PageAccountListResponse result = accountingService.findAccountingByMonth(monthId, page, size, startTime, endTime);

        // Assert
        assertEquals(accountResponses, result.getAccountResponseList());
        assertTrue(result.getHasNext());
        assertFalse(result.getHasPrevious());
        assertEquals(100L, result.getTotalList().getTotalRemain());
        assertEquals(5L, result.getTotalPages()); // Assuming size=10 and totalRecordCount=50
    }

    @Test
    void createAccounting() {
        AccountingCreateRequest accountingCreateRequest = mock(AccountingCreateRequest.class);
        User currentUser = mock(User.class);
        MultipartFile[] billFile = new MultipartFile[] {};

        when(accountingCreateRequest.getUserId()).thenReturn("1");
        when(userMapper.findById("1")).thenReturn(currentUser);
        when(accountingMapper.getLatestRemain(anyString())).thenReturn(100L);
        doNothing().when(applicationUtils).checkValidateFile(eq(Accounting.class), eq(billFile));

        int result = accountingService.createAccounting(accountingCreateRequest);

        // Assert
        assertEquals(1, result); // Assuming successful creation
    }

//    @Test
//    public void testUpdateAccounting() {
//        String input = "231002121630-Accounting Management Interface.xlsx,231002121635-Accounting Management Interface.xlsx";
//        String[] result = input.split(",");
//        HttpSession session = mock(HttpSession.class);
//        ServletContext servletContext = mock(ServletContext.class);
//        when(request.getSession()).thenReturn(session);
//        when(session.getServletContext()).thenReturn(servletContext);
//        AccountingUpdateRequest updateRequest = new AccountingUpdateRequest("1",30000L,50000L,"3",result,new MultipartFile[]{},"abc","xyz");
//        when(accountingMapper.findAccountingById(updateRequest.getId())).thenReturn(new Accounting());
//        when(userMapper.findById(updateRequest.getUserId())).thenReturn(new User());
//        when(fileUtils.saveMultipleFilesToServer(eq(request), anyString(), any(MultipartFile[].class)))
//                .thenReturn(Arrays.asList("newFile1", "newFile2"));
//        when(accountingConverter.convertToEntity(eq(updateRequest), any(User.class), anyList()))
//                .thenReturn(new Accounting());
//
//        // Act
//        AccountResponse response = accountingService.updateAccounting(updateRequest);
//
//        // Assert
//        assertNotNull(response);
//        // Kiểm tra rằng các phương thức của accountingMapper, fileUtils đã được gọi đúng cách
//        verify(accountingMapper).updateAccounting(any(Accounting.class));
//    }
//
//    @Test
//    public void testUpdateAccountingWithException() {
//        FileUtils fileUtils = mock(FileUtils.class);
//        // Arrange
//        AccountingUpdateRequest updateRequest = new AccountingUpdateRequest();
//        when(accountingMapper.findAccountingById(updateRequest.getId())).thenReturn(new Accounting());
//        when(userMapper.findById(updateRequest.getUserId())).thenReturn(new User());
//        when(fileUtils.saveMultipleFilesToServer(eq(request), anyString(), any(MultipartFile[].class)))
//                .thenReturn(Arrays.asList("newFile1", "newFile2"));
//        when(accountingConverter.convertToEntity(eq(updateRequest), any(User.class), anyList()))
//                .thenReturn(new Accounting());
//        doThrow(new Exception()).when(accountingMapper).updateAccounting(any(Accounting.class));
//
//        // Act
//        AccountResponse response = accountingService.updateAccounting(updateRequest);
//
//        // Assert
//        assertNull(response);
//        // Kiểm tra rằng deleteMultipleFilesToServer đã được gọi khi có lỗi
//        verify(fileUtils).deleteMultipleFilesToServer(eq(request), anyString(), anyString());
//    }

    @Test
    public void testDeleteAccounting() {
        String accountingId = "123";
        Accounting deleteAccounting = new Accounting();
        deleteAccounting.setId(accountingId);
        List<Accounting> remainRecordInMonthList = new ArrayList<>();

        when(accountingMapper.findAccountingById(accountingId)).thenReturn(deleteAccounting);
        when(accountingMapper.findBeforeCurrentAccounting(deleteAccounting)).thenReturn(null);
        when(accountingMapper.getRemainRecordInMonth(deleteAccounting)).thenReturn(remainRecordInMonthList);

        int result = accountingService.deleteAccounting(accountingId);

        assertEquals(1, result);
        verify(accountingMapper).deleteAccounting(accountingId);
        verify(accountingMapper, times(0)).updateRecordsBatch(anyList());
    }

    @Test
    public void testDeleteAccountingNotFound() {
        String accountingId = "123";
        when(accountingMapper.findAccountingById(accountingId)).thenReturn(null);
        int result = accountingService.deleteAccounting(accountingId);
        assertEquals(0, result);
    }

    @Test
    void findAccountingById() {
        Accounting accounting = new Accounting("111ec17d-3921-4bf7-8fcd-283d2fc8d0ec", DateUtils.toLocalDateTime("2023-07-27 14:14:46"), 100000L, 120000L, new User(), null, "Buy Rice", StatusAccountingEnum.ACTIVE, "abcxyz");
        AccountResponse accountResponse = accountingConverter.convertToResponseDTO(accounting);
        when(accountingMapper.findAccountingById("111ec17d-3921-4bf7-8fcd-283d2fc8d0ec")).thenReturn(accounting);
        when(accountingConverter.convertToResponseDTO(accounting)).thenReturn(accountResponse);
        AccountResponse actual = accountingService.findAccountingById("111ec17d-3921-4bf7-8fcd-283d2fc8d0ec");
        verify(accountingMapper).findAccountingById("111ec17d-3921-4bf7-8fcd-283d2fc8d0ec");
        assertEquals(accountResponse, actual);
    }

}
