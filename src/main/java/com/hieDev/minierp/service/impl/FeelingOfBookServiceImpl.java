package com.hieDev.minierp.service.impl;

import com.hieDev.minierp.converter.FeelingOfBookConverter;
import com.hieDev.minierp.exception.NotFoundException;
import com.hieDev.minierp.entity.FeelingOfBook;
import com.hieDev.minierp.mapper.FeelingOfBookMapper;
import com.hieDev.minierp.model.request.feelingofbook.FeelingOfBookCreateRequest;
import com.hieDev.minierp.model.request.feelingofbook.FeelingOfBookUpdateRequest;
import com.hieDev.minierp.model.response.feelingofbook.FeelingOfBookResponse;
import com.hieDev.minierp.service.FeelingOfBookService;
import com.hieDev.minierp.utils.MessageErrorUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class FeelingOfBookServiceImpl implements FeelingOfBookService {

    @Autowired
    private FeelingOfBookMapper feelingOfBookMapper;

    @Autowired
    private FeelingOfBookConverter feelingOfBookConverter;

    @Override
    public List<FeelingOfBookResponse> findAllByBook(String bookId) {
        List<FeelingOfBook> feelingOfBooks = feelingOfBookMapper.findAllByBook(bookId);
        return feelingOfBookConverter.toListResponse(feelingOfBooks);
    }

    @Override
    public FeelingOfBookResponse createFeelingOfBook(FeelingOfBookCreateRequest feelingOfBookCreateRequest) {

        if (feelingOfBookCreateRequest.getBookId() == null)
            throw new NotFoundException(MessageErrorUtils.notFound("bookId"));
        else if (feelingOfBookCreateRequest.getUserId() == null)
            throw new NotFoundException(MessageErrorUtils.notFound("userId"));

        FeelingOfBook feelingOfBook = feelingOfBookConverter.toEntity(feelingOfBookCreateRequest);
        try {
            feelingOfBookMapper.createFeelingOfBook(feelingOfBook);
        } catch (Exception e) {
            return null;
        }
        return feelingOfBookConverter.toResponse(feelingOfBook);
    }

    @Override
    public FeelingOfBookResponse findById(String id) {
        return feelingOfBookConverter.toResponse(feelingOfBookMapper.findById(id));
    }

    @Override
    public FeelingOfBookResponse updateFeelingOfBook(FeelingOfBookUpdateRequest feelingOfBookUpdateRequest) {

        if (feelingOfBookUpdateRequest.getBookId() == null)
            throw new NotFoundException(MessageErrorUtils.notFound("bookId"));
        else if (feelingOfBookUpdateRequest.getUserId() == null)
            throw new NotFoundException(MessageErrorUtils.notFound("userId"));

        FeelingOfBook feelingOfBook = feelingOfBookConverter.toEntity(feelingOfBookUpdateRequest);
        try {
            feelingOfBookMapper.updateFeelingOfBook(feelingOfBook);
        } catch (Exception e) {
            return null;
        }
        return feelingOfBookConverter.toResponse(feelingOfBook);
    }

    @Override
    public FeelingOfBookResponse findByUserAndBook(String bookId, String userId) {
        return feelingOfBookConverter.toResponse(feelingOfBookMapper.findByUserAndBook(userId, bookId));
    }

    @Override
    public int deleteFeelingOfBook(String bookId, String userId) {
        try {
            feelingOfBookMapper.deleteFeelingOfBook(bookId, userId);
            return 1;
        } catch (Exception e) {
        }
        return 0;
    }
}
