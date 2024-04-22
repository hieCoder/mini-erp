package com.shsoftvina.erpshsoftvina.service.impl;

import com.shsoftvina.erpshsoftvina.converter.TagConverter;
import com.shsoftvina.erpshsoftvina.entity.Book;
import com.shsoftvina.erpshsoftvina.entity.Tag;
import com.shsoftvina.erpshsoftvina.exception.NotFoundException;
import com.shsoftvina.erpshsoftvina.mapper.TagMapper;
import com.shsoftvina.erpshsoftvina.model.request.tag.TagCreateRequest;
import com.shsoftvina.erpshsoftvina.model.request.tag.TagUpdateRequest;
import com.shsoftvina.erpshsoftvina.model.response.tag.TagResponse;
import com.shsoftvina.erpshsoftvina.service.TagService;
import com.shsoftvina.erpshsoftvina.utils.MessageErrorUtils;
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
