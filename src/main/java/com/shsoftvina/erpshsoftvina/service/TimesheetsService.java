package com.shsoftvina.erpshsoftvina.service;

import com.shsoftvina.erpshsoftvina.model.response.timesheets.TimesheetsResponse;

import java.util.List;

public interface TimesheetsService {
    List<TimesheetsResponse> findAll(int start, int pageSize);
}
