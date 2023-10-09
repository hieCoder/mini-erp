package com.shsoftvina.erpshsoftvina.api;

import com.shsoftvina.erpshsoftvina.model.request.accountings.AccountingCreateRequest;
import com.shsoftvina.erpshsoftvina.model.request.accountings.AccountingUpdateRequest;
import com.shsoftvina.erpshsoftvina.model.response.accountings.MonthHistoryList;
import com.shsoftvina.erpshsoftvina.model.response.accountings.PageAccountListResponse;
import com.shsoftvina.erpshsoftvina.service.AccountingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.validation.Valid;
import java.time.LocalDate;

@RestController
@RequestMapping("/api/v1/accounts")
public class AccountingApi {
    @Autowired
    private AccountingService accountingService;

    @GetMapping()
    public ResponseEntity<?> findAllMonthlyHistory() {
        return ResponseEntity.ok(accountingService.findAllMonthlyHistory());
    }

    @GetMapping("/{monthId}")
    public ResponseEntity<?> findAccountingByMonth(@PathVariable("monthId") String monthId,
                                                   @RequestParam(name = "page",required = false,defaultValue = "1") Integer page,
                                                   @RequestParam(name = "size", required = false, defaultValue = "5") Integer size,
                                                   @RequestParam(name = "startDate", required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
                                                   @RequestParam(name = "endDate", required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate
    ) {
        PageAccountListResponse accountListResponse = accountingService.findAccountingByMonth(monthId,page,size,startDate,endDate);
        return ResponseEntity.ok(accountListResponse);
    }

    @PostMapping()
    public ResponseEntity<?> createAccounting(@Valid AccountingCreateRequest accountingCreateRequest,BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
        accountingService.createAccounting(accountingCreateRequest);
        return new ResponseEntity<>(HttpStatus.CREATED);
    }

    @PostMapping("/edit")
    public ResponseEntity<?> updateAccounting(@Valid AccountingUpdateRequest accountingUpdateRequest, BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>(accountingService.updateAccounting(accountingUpdateRequest),HttpStatus.FOUND);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteAccounting(@PathVariable("id") String id) {
        return ResponseEntity.ok(accountingService.deleteAccounting(id));
    }
}

