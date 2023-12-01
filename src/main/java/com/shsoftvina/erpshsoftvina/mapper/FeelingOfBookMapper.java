package com.shsoftvina.erpshsoftvina.mapper;


import com.shsoftvina.erpshsoftvina.entity.FeelingOfBook;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface FeelingOfBookMapper {
    int createFeelingOfBook(FeelingOfBook feelingOfBook);
    FeelingOfBook findById(String id);
    FeelingOfBook findByUserAndBook(String userId, String bookId);
    int updateFeelingOfBook(FeelingOfBook feelingOfBook);
    int deleteFeelingOfBook(String bookId,
                            String userId);
    List<FeelingOfBook> findAllByBook(String id);
}