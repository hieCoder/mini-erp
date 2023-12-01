package com.shsoftvina.erpshsoftvina.service.impl;

import com.shsoftvina.erpshsoftvina.converter.FeelingOfBookConverter;
import com.shsoftvina.erpshsoftvina.entity.FeelingOfBook;
import com.shsoftvina.erpshsoftvina.exception.NotFoundException;
import com.shsoftvina.erpshsoftvina.mapper.BookMapper;
import com.shsoftvina.erpshsoftvina.mapper.FeelingOfBookMapper;
import com.shsoftvina.erpshsoftvina.mapper.UserMapper;
import com.shsoftvina.erpshsoftvina.model.request.feelingofbook.FeelingOfBookCreateRequest;
import com.shsoftvina.erpshsoftvina.model.request.feelingofbook.FeelingOfBookUpdateRequest;
import com.shsoftvina.erpshsoftvina.model.response.feelingofbook.FeelingOfBookResponse;
import com.shsoftvina.erpshsoftvina.service.FeelingOfBookService;
import com.shsoftvina.erpshsoftvina.utils.MessageErrorUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class FeelingOfBookServiceImpl implements FeelingOfBookService {

    @Autowired
    private FeelingOfBookMapper feelingOfBookMapper;

    @Autowired
    private FeelingOfBookConverter feelingOfBookConverter;

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
