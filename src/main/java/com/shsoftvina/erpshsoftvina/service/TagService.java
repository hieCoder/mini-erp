package com.shsoftvina.erpshsoftvina.service;

import com.shsoftvina.erpshsoftvina.model.request.tag.TagCreateRequest;
import com.shsoftvina.erpshsoftvina.model.request.tag.TagUpdateRequest;
import com.shsoftvina.erpshsoftvina.model.response.tag.TagResponse;

import java.util.List;

public interface TagService {
    List<TagResponse> findAll();
    int createTag(TagCreateRequest tagCreateRequest);
    int updateTag(TagUpdateRequest tagUpdateRequest);
    int deleteTag(String id);
}