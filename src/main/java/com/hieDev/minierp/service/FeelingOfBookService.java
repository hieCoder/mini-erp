package com.hieDev.minierp.service;

import com.hieDev.minierp.model.request.feelingofbook.FeelingOfBookCreateRequest;
import com.hieDev.minierp.model.request.feelingofbook.FeelingOfBookUpdateRequest;
import com.hieDev.minierp.model.response.feelingofbook.FeelingOfBookResponse;

import java.util.List;

public interface FeelingOfBookService {

    List<FeelingOfBookResponse> findAllByBook(String bookId);
    FeelingOfBookResponse createFeelingOfBook(FeelingOfBookCreateRequest feelingOfBookCreateRequest);
    FeelingOfBookResponse findById(String id);
    FeelingOfBookResponse updateFeelingOfBook(FeelingOfBookUpdateRequest feelingOfBookUpdateRequest);
    FeelingOfBookResponse findByUserAndBook(String bookId, String userId);
    int deleteFeelingOfBook(String bookId, String userId);
}