package com.hieDev.minierp.service;

import com.hieDev.minierp.model.request.tag.TagCreateRequest;
import com.hieDev.minierp.model.request.tag.TagUpdateRequest;
import com.hieDev.minierp.model.response.tag.TagResponse;

import java.util.List;

public interface TagService {
    List<TagResponse> findAll();
    int createTag(TagCreateRequest tagCreateRequest);
    int updateTag(TagUpdateRequest tagUpdateRequest);
    int deleteTag(String id);
}