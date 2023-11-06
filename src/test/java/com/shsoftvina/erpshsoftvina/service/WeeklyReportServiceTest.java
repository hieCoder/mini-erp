package com.shsoftvina.erpshsoftvina.service;

import com.shsoftvina.erpshsoftvina.converter.WeeklyReportConverter;
import com.shsoftvina.erpshsoftvina.entity.WeeklyReport;
import com.shsoftvina.erpshsoftvina.mapper.WeeklyReportMapper;
import com.shsoftvina.erpshsoftvina.model.response.weeklyReport.PageWeeklyReportListRespone;
import com.shsoftvina.erpshsoftvina.model.response.weeklyReport.WeeklyReportShowResponse;
import com.shsoftvina.erpshsoftvina.service.impl.WeeklyReportServiceImpl;
import com.shsoftvina.erpshsoftvina.utils.ApplicationUtils;
import org.apache.ibatis.session.RowBounds;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.util.Arrays;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.*;

public class WeeklyReportServiceTest {
}
