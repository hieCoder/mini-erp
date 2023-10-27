package com.shsoftvina.erpshsoftvina.mapper;


import com.shsoftvina.erpshsoftvina.entity.FeelingOfBook;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface FeelingOfBookMapper {
    List<FeelingOfBook> findAll();
    int createFeelingOfBook(FeelingOfBook feelingOfBook);
    FeelingOfBook findById(String id);
    int updateFeelingOfBook(FeelingOfBook feelingOfBook);
    int deleteFeelingOfBook(@Param("bookId") String bookId,
                            @Param("userId") String userId);
    List<FeelingOfBook> findAllByBook(String id);
    FeelingOfBook findFeelingByUser(@Param("bookId") String bookId,
                                    @Param("userId") String userId);
}