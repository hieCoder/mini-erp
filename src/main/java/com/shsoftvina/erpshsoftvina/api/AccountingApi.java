package com.shsoftvina.erpshsoftvina.api;

import com.shsoftvina.erpshsoftvina.model.response.accountings.MonthHistoryList;
import com.shsoftvina.erpshsoftvina.model.response.accountings.PageAccountListResponse;
import com.shsoftvina.erpshsoftvina.service.AccountingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/accounts")
public class AccountingApi {
    @Autowired
    private AccountingService accountingService;

    @GetMapping()
    public ResponseEntity<?> findAllMonthlyHistory() {
        MonthHistoryList monthlyHistory = accountingService.findAllMonthlyHistory();
        return ResponseEntity.ok(monthlyHistory);
    }

    @GetMapping("/{monthId}")
    public ResponseEntity<?> findAccountingByMonth(@PathVariable("monthId") Integer monthId,
                                                   @RequestParam(name = "page",required = false,defaultValue = "0") Integer page,
                                                   @RequestParam(name = "size", required = false, defaultValue = "5") Integer size
                                                   ) {

        PageAccountListResponse accountListResponse = accountingService.findAccountingByMonth(monthId,page,size);
        return ResponseEntity.ok(accountListResponse);
    }
}
