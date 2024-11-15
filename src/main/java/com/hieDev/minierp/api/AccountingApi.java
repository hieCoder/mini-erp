package com.hieDev.minierp.api;

import com.hieDev.minierp.model.request.accountings.AccountingCreateRequest;
import com.hieDev.minierp.model.request.accountings.AccountingUpdateRequest;
import com.hieDev.minierp.service.AccountingService;
import com.hieDev.minierp.utils.ValidateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.validation.Valid;
import java.time.LocalDate;
import java.util.Map;

@RestController
@RequestMapping("/api/v1/accounts")
public class AccountingApi {
    @Autowired
    private AccountingService accountingService;

    @GetMapping("total-month")
    public ResponseEntity<?> findAllMonthlyHistory() {
        return ResponseEntity.ok(accountingService.findAllMonthlyHistory());
    }

    @GetMapping()
    public ResponseEntity<?> findAccountingByMonth(@RequestParam(name = "page",required = false,defaultValue = "1") Integer page,
                                                                                            @RequestParam(name = "size", required = false, defaultValue = "10") Integer size,
                                                                                            @RequestParam(name = "startDate", required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
                                                                                            @RequestParam(name = "endDate", required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate
    ) {
        {
            return ResponseEntity.ok(accountingService.findAccountingByMonth(page, size, startDate, endDate));

        }
    }

    @PostMapping()
    public ResponseEntity<?> createAccounting(AccountingCreateRequest accountingCreateRequest) throws IllegalAccessException {
        Map<String, String> errors = ValidateUtils.validate(accountingCreateRequest);
        if (errors.isEmpty()) {
            return new ResponseEntity<>(accountingService.createAccounting(accountingCreateRequest),HttpStatus.OK);
        } else {
            return new ResponseEntity<>(errors,HttpStatus.BAD_REQUEST);
        }
    }

    @PostMapping("/edit")
    public ResponseEntity<?> updateAccounting(@Valid AccountingUpdateRequest accountingUpdateRequest, BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>(accountingService.updateAccounting(accountingUpdateRequest),HttpStatus.OK);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteAccounting(@PathVariable("id") String id) {
        return ResponseEntity.ok(accountingService.deleteAccounting(id));
    }

    @GetMapping("/detail/{id}")
    public ResponseEntity<?> detailAccounting(@PathVariable("id") String id) {
        return ResponseEntity.ok(accountingService.findAccountingById(id));
    }

    @GetMapping("/balance")
    public ResponseEntity<?> getRemainBalanceEachMonth() {
        return ResponseEntity.ok(accountingService.getRemainBalanceEachMonth());
    }

}

