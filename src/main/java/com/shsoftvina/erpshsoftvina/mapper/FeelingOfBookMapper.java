package com.shsoftvina.erpshsoftvina.mapper;


import com.shsoftvina.erpshsoftvina.entity.Book;
import com.shsoftvina.erpshsoftvina.entity.FeelingOfBook;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface FeelingOfBookMapper {
    List<FeelingOfBook> findAll();
    int createFeelingOfBook(FeelingOfBook feelingOfBook);
    FeelingOfBook findById(String id);
    int updateFeelingOfBook(FeelingOfBook feelingOfBook);
    int deleteFeelingOfBook(String id);
}