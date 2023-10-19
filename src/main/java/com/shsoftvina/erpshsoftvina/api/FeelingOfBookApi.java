package com.shsoftvina.erpshsoftvina.api;

import com.shsoftvina.erpshsoftvina.model.request.feelingofbook.FeelingOfBookCreateRequest;
import com.shsoftvina.erpshsoftvina.model.request.feelingofbook.FeelingOfBookUpdateRequest;
import com.shsoftvina.erpshsoftvina.service.FeelingOfBookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

@RestController
@RequestMapping("/api/v1/feeling-of-book")
public class FeelingOfBookApi {

    @Autowired
    private FeelingOfBookService feelingOfBookService;

    @GetMapping
    public ResponseEntity<?> findAll() {
        return ResponseEntity.ok(feelingOfBookService.findAll());
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> findById(@PathVariable("id") String id) {
        return ResponseEntity.ok(feelingOfBookService.findById(id));
    }

    @GetMapping("/{bookId}/{userId}")
    public ResponseEntity<?> findByUser(@PathVariable("bookId") String bookId,
                                        @PathVariable("userId") String userId) {
        return ResponseEntity.ok(feelingOfBookService.findFeelingByUser(bookId,userId));
    }

    @PostMapping
    public ResponseEntity<?> createFeelingOfBook(@Valid @RequestBody FeelingOfBookCreateRequest feelingOfBookCreateRequest) {
        return ResponseEntity.ok(feelingOfBookService.createFeelingOfBook(feelingOfBookCreateRequest));
    }

    @PutMapping
    public ResponseEntity<?> updateFeelingOfBook(@Valid @RequestBody FeelingOfBookUpdateRequest feelingOfBookUpdateRequest) {
        return ResponseEntity.ok(feelingOfBookService.updateFeelingOfBook(feelingOfBookUpdateRequest));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteFeelingOfBook(@PathVariable String id) {
        return ResponseEntity.ok(feelingOfBookService.deleteFeelingOfBook(id));
    }
}
