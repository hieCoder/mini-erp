package com.hieDev.minierp.mapper;


import com.hieDev.minierp.entity.FeelingOfBook;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface FeelingOfBookMapper {
    int createFeelingOfBook(FeelingOfBook feelingOfBook);
    FeelingOfBook findById(String id);
    FeelingOfBook findByUserAndBook(String userId, String bookId);
    int updateFeelingOfBook(FeelingOfBook feelingOfBook);
    int deleteFeelingOfBook(String bookId,
                            String userId);
    List<FeelingOfBook> findAllByBook(String bookId);
    FeelingOfBook findFeelingByUser(String bookId,
                                    String userId);
}