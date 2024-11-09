package com.hieDev.minierp.mapper;


import com.hieDev.minierp.entity.Setting;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface SettingMapper {

    List<Setting> findAll();
    int updateSetting(Setting setting);
    Setting findById(String id);
    Setting findByCode(String code);
}