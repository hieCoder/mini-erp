package com.shsoftvina.erpshsoftvina.service;

import com.shsoftvina.erpshsoftvina.model.request.feelingofbook.FeelingOfBookCreateRequest;
import com.shsoftvina.erpshsoftvina.model.request.feelingofbook.FeelingOfBookUpdateRequest;
import com.shsoftvina.erpshsoftvina.model.response.feelingofbook.FeelingOfBookResponse;

import java.util.List;

public interface FeelingOfBookService {
    List<FeelingOfBookResponse> findAllByBook(String bookId);
    FeelingOfBookResponse createFeelingOfBook(FeelingOfBookCreateRequest feelingOfBookCreateRequest);
    FeelingOfBookResponse findById(String id);
    FeelingOfBookResponse updateFeelingOfBook(FeelingOfBookUpdateRequest feelingOfBookUpdateRequest);
    FeelingOfBookResponse findFeelingByUser(String bookId, String userId);
    int deleteFeelingOfBook(String bookId, String userId);
}