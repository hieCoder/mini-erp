package com.shsoftvina.erpshsoftvina.converter;

import com.shsoftvina.erpshsoftvina.entity.FeelingOfBook;
import com.shsoftvina.erpshsoftvina.mapper.BookMapper;
import com.shsoftvina.erpshsoftvina.mapper.FeelingOfBookMapper;
import com.shsoftvina.erpshsoftvina.mapper.UserMapper;
import com.shsoftvina.erpshsoftvina.model.request.feelingofbook.FeelingOfBookCreateRequest;
import com.shsoftvina.erpshsoftvina.model.request.feelingofbook.FeelingOfBookUpdateRequest;
import com.shsoftvina.erpshsoftvina.model.response.feelingofbook.FeelingOfBookResponse;
import com.shsoftvina.erpshsoftvina.utils.ApplicationUtils;
import com.shsoftvina.erpshsoftvina.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@Component
public class FeelingOfBookConverter {

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private BookMapper bookMapper;

    @Autowired
    private FeelingOfBookMapper feelingOfBookMapper;

    @Autowired
    private UserConverter userConverter;

    @Autowired
    private CommentFeelingBookConverter commentFeelingBookConverter;

    public FeelingOfBookResponse toResponse(FeelingOfBook feelingOfBook) {
        if(feelingOfBook == null) return null;
        return FeelingOfBookResponse.builder()
                .id(feelingOfBook.getId())
                .bookReport(feelingOfBook.getBookReport())
                .createdDate(DateUtils.formatDateTime(feelingOfBook.getCreatedDate()))
                .timeSpentReading(feelingOfBook.getTimeSpentReading())
                .note(feelingOfBook.getNote())
                .user(userConverter.toFullnameAndAvatarResponse(feelingOfBook.getUser()))
                .comments(commentFeelingBookConverter.toListResponse(feelingOfBook.getComments()))
                .build();
    }

    public List<FeelingOfBookResponse> toListResponse(List<FeelingOfBook> feelingOfBooks){
        return feelingOfBooks.stream().map(this::toResponse).collect(Collectors.toList());
    }

    public FeelingOfBook toEntity(FeelingOfBookCreateRequest feelingOfBookCreateRequest){
        return FeelingOfBook.builder()
                .id(ApplicationUtils.generateId())
                .user(userMapper.findById(feelingOfBookCreateRequest.getUserId()))
                .bookReport(feelingOfBookCreateRequest.getBookReport())
                .createdDate(new Date())
                .timeSpentReading(feelingOfBookCreateRequest.getTimeSpentReading())
                .note(feelingOfBookCreateRequest.getNote())
                .book(bookMapper.findById(feelingOfBookCreateRequest.getBookId())).build();
    }

    public FeelingOfBook toEntity(FeelingOfBookUpdateRequest feelingOfBookUpdateRequest){
        FeelingOfBook feelingOfBook = feelingOfBookMapper.findByUserAndBook(feelingOfBookUpdateRequest.getUserId(), feelingOfBookUpdateRequest.getBookId());
        feelingOfBook.setBookReport(feelingOfBookUpdateRequest.getBookReport());
        feelingOfBook.setTimeSpentReading(feelingOfBookUpdateRequest.getTimeSpentReading());
        feelingOfBook.setNote(feelingOfBookUpdateRequest.getNote());
        return feelingOfBook;
    }
}