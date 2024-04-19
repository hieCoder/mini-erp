package com.shsoftvina.erpshsoftvina.entity;

import com.shsoftvina.erpshsoftvina.enums.tag.TypeTagEnum;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.bouncycastle.cms.PasswordRecipientId;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Tag {

    private String id;
    private String tagName;
    private TypeTagEnum type;
}