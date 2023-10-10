package com.shsoftvina.erpshsoftvina.mapper;


import com.shsoftvina.erpshsoftvina.entity.Setting;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface SettingMapper {

    List<Setting> findAll();
    int updateSetting(Setting setting);
    Setting findById(String id);
}