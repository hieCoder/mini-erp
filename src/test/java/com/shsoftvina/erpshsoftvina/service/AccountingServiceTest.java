package com.shsoftvina.erpshsoftvina.service;

import com.shsoftvina.erpshsoftvina.constant.AccountingConstant;
import com.shsoftvina.erpshsoftvina.converter.AccountingConverter;
import com.shsoftvina.erpshsoftvina.entity.Accounting;
import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.enums.accounting.StatusAccountingEnum;
import com.shsoftvina.erpshsoftvina.mapper.AccountingMapper;
import com.shsoftvina.erpshsoftvina.mapper.UserMapper;
import com.shsoftvina.erpshsoftvina.model.request.accountings.AccountingCreateRequest;
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

import javax.servlet.http.HttpServletRequest;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import static org.hamcrest.Matchers.any;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@WebAppConfiguration
public class AccountingServiceTest {
    @Mock
    private UserMapper userMapper;

    @Mock
    private HttpServletRequest request;
    @Mock
    private ApplicationUtils applicationUtils;
    @Mock
    private FileUtils fileUtils;
    @Mock
    private AccountingMapper accountingMapper;
    private final AccountingConverter accountingConverter = Mockito.mock(AccountingConverter.class);
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

//    @Test
//    void createAccounting() {
//        // Arrange
//        AccountingCreateRequest accountingCreateRequest = new AccountingCreateRequest(); // Mock your request
//        User currentUser = new User(); // Mock the current user
//        MultipartFile[] billFile = new MultipartFile[] {}; // Mock your bill files
//
//        when(accountingCreateRequest.getUserId()).thenReturn("1");
//        when(userMapper.findById("1")).thenReturn(currentUser);
//        when(accountingMapper.getLatestRemain(anyString())).thenReturn(100L);
//        when(applicationUtils.checkValidateFile(Accounting.class, billFile)).thenReturn(true);
//        when(fileUtils.saveMultipleFilesToServer(request, AccountingConstant.UPLOAD_FILE_DIR, billFile))
//                .thenReturn(new ArrayList<>()); // Mock an empty list for successful file saving
//
//        // Act
//        int result = accountingService.createAccounting(accountingCreateRequest);
//
//        // Assert
//        assertEquals(1, result); // Assuming successful creation
//    }

    @Test
    void updateAccounting() {

    }

    @Test
    void deleteAccounting() {

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
