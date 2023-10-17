package com.shsoftvina.erpshsoftvina.converter;

import com.shsoftvina.erpshsoftvina.entity.FeelingOfBook;
import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.mapper.BookMapper;
import com.shsoftvina.erpshsoftvina.mapper.UserMapper;
import com.shsoftvina.erpshsoftvina.model.request.feelingofbook.FeelingOfBookCreateRequest;
import com.shsoftvina.erpshsoftvina.model.request.feelingofbook.FeelingOfBookUpdateRequest;
import com.shsoftvina.erpshsoftvina.model.response.feelingofbook.FeelingOfBookResponse;
import com.shsoftvina.erpshsoftvina.utils.DateUtils;
import com.shsoftvina.erpshsoftvina.utils.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.UUID;

@Component
public class FeelingOfBookConverter {

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private BookMapper bookMapper;

    public FeelingOfBookResponse toResponse(FeelingOfBook feelingOfBook) {
        return FeelingOfBookResponse.builder()
                .id(feelingOfBook.getId())
                .quotes(feelingOfBook.getQuote().split("---"))
                .createdDate(DateUtils.formatDate(feelingOfBook.getCreatedDate()))
                .idUser(feelingOfBook.getUser().getId())
                .fullnameUser(feelingOfBook.getUser().getFullname())
                .avatarUser(FileUtils.getPathUpload(User.class,feelingOfBook.getUser().getAvatar()))
                .build();
    }

    public FeelingOfBook toEntity(FeelingOfBookCreateRequest feelingOfBookCreateRequest){
        return FeelingOfBook.builder()
                .id(UUID.randomUUID().toString())
                .user(userMapper.findById(feelingOfBookCreateRequest.getUserId()))
                .quote(feelingOfBookCreateRequest.getQuote())
                .createdDate(new Date())
                .book(bookMapper.findById(feelingOfBookCreateRequest.getBookId())).build();
    }

    public FeelingOfBook toEntity(FeelingOfBookUpdateRequest feelingOfBookUpdateRequest){
        return FeelingOfBook.builder()
                .id(feelingOfBookUpdateRequest.getId())
                .quote(feelingOfBookUpdateRequest.getQuote()).build();
    }
}