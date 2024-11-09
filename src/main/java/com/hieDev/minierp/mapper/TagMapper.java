package com.hieDev.minierp.mapper;

import com.hieDev.minierp.entity.Tag;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface TagMapper {
    List<Tag> findAll();
    Tag findById(String id);
    int createTag(Tag Tag);
    int updateTag(Tag tag);
    int deleteTag(String id);
}
