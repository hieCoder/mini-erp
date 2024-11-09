package com.hieDev.minierp.entity;

import com.hieDev.minierp.enums.tag.TypeTagEnum;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Tag {

    private String id;
    private String tagName;
    private TypeTagEnum type;
}