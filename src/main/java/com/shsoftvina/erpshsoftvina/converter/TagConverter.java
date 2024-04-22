package com.shsoftvina.erpshsoftvina.converter;

import com.shsoftvina.erpshsoftvina.entity.Tag;
import com.shsoftvina.erpshsoftvina.enums.tag.TypeTagEnum;
import com.shsoftvina.erpshsoftvina.model.request.tag.TagCreateRequest;
import com.shsoftvina.erpshsoftvina.model.request.tag.TagUpdateRequest;
import com.shsoftvina.erpshsoftvina.model.response.tag.TagResponse;
import com.shsoftvina.erpshsoftvina.utils.ApplicationUtils;
import com.shsoftvina.erpshsoftvina.utils.EnumUtils;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.stream.Collectors;

@Component
public class TagConverter {

    public TagResponse toResponse(Tag tag) {
        return TagResponse.builder()
                .id(tag.getId())
                .tagName(tag.getTagName())
                .type(EnumUtils.instance(tag.getType()))
                .build();
    }

    public List<TagResponse> toListResponse(List<Tag> tags) {
        return tags.stream().map(this::toResponse).collect(Collectors.toList());
    }

    public Tag toEntity(TagCreateRequest tagRequest) {
        return Tag.builder()
                .id(ApplicationUtils.generateId())
                .tagName(tagRequest.getTagName())
                .type(EnumUtils.getEnumFromValue(TypeTagEnum.class, tagRequest.getType()))
                .build();
    }

    public Tag toEntity(TagUpdateRequest tagUpdateRequest) {
        return Tag.builder()
                .id(tagUpdateRequest.getId())
                .tagName(tagUpdateRequest.getTagName())
                .type(EnumUtils.getEnumFromValue(TypeTagEnum.class, tagUpdateRequest.getType()))
                .build();
    }
}
