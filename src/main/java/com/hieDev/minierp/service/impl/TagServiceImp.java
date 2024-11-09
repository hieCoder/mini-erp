package com.hieDev.minierp.service.impl;

import com.hieDev.minierp.converter.TagConverter;
import com.hieDev.minierp.exception.NotFoundException;
import com.hieDev.minierp.entity.Tag;
import com.hieDev.minierp.mapper.TagMapper;
import com.hieDev.minierp.model.request.tag.TagCreateRequest;
import com.hieDev.minierp.model.request.tag.TagUpdateRequest;
import com.hieDev.minierp.model.response.tag.TagResponse;
import com.hieDev.minierp.service.TagService;
import com.hieDev.minierp.utils.MessageErrorUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TagServiceImp implements TagService {

    @Autowired
    private TagMapper tagMapper;

    @Autowired
    private TagConverter tagConverter;

    @Override
    public List<TagResponse> findAll() {
        return tagConverter.toListResponse(tagMapper.findAll());
    }

    @Override
    public int createTag(TagCreateRequest tagCreateRequest) {
        try {
            tagMapper.createTag(tagConverter.toEntity(tagCreateRequest));
            return 1;
        } catch (Exception e) {
            return 0;
        }
    }

    @Override
    public int updateTag(TagUpdateRequest tagUpdateRequest) {
        Tag tag = tagMapper.findById(tagUpdateRequest.getId());
        if (tag == null)  throw new NotFoundException(MessageErrorUtils.notFound("id"));

        return tagMapper.updateTag(tagConverter.toEntity(tagUpdateRequest));
    }

    @Override
    public int deleteTag(String id) {
        Tag tag = tagMapper.findById(id);
        if (tag == null)  throw new NotFoundException(MessageErrorUtils.notFound("id"));

        return tagMapper.deleteTag(id);
    }

}
