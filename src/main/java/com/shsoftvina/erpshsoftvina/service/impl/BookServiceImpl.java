package com.shsoftvina.erpshsoftvina.service.impl;

import com.shsoftvina.erpshsoftvina.constant.BookConstant;
import com.shsoftvina.erpshsoftvina.converter.BookConverter;
import com.shsoftvina.erpshsoftvina.entity.Book;
import com.shsoftvina.erpshsoftvina.exception.NotFoundException;
import com.shsoftvina.erpshsoftvina.mapper.BookMapper;
import com.shsoftvina.erpshsoftvina.model.request.book.BookCreateRequest;
import com.shsoftvina.erpshsoftvina.model.request.book.BookUpdateRequest;
import com.shsoftvina.erpshsoftvina.model.response.book.BookDetailResponse;
import com.shsoftvina.erpshsoftvina.model.response.book.PageBookListRespone;
import com.shsoftvina.erpshsoftvina.model.response.book.ShowBookResponse;
import com.shsoftvina.erpshsoftvina.service.BookService;
import com.shsoftvina.erpshsoftvina.utils.ApplicationUtils;
import com.shsoftvina.erpshsoftvina.utils.FileUtils;
import com.shsoftvina.erpshsoftvina.utils.MessageErrorUtils;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Service
public class BookServiceImpl implements BookService {

    @Autowired
    private BookMapper bookMapper;

    @Autowired
    private HttpServletRequest request;

    @Autowired
    private BookConverter bookConverter;

    @Autowired
    private ApplicationUtils applicationUtils;

    @Override
    public PageBookListRespone fillAll(String searchTerm, int start, int pageSize) {
        int offset = (start - 1) * pageSize;
        RowBounds rowBounds = new RowBounds(offset, pageSize);
        List<Book> books = bookMapper.findAll(searchTerm, rowBounds);
        List<ShowBookResponse> showBooks = bookConverter.toListShowBookResponse(books);
        long totalRecordBook = bookMapper.totalBook(searchTerm);
        long totalPage = (long) Math.ceil((double) totalRecordBook / pageSize);
        boolean hasNext = start < totalPage;
        boolean hasPrevious = start > 1;

        return new PageBookListRespone(showBooks, start, totalPage, pageSize, hasNext, hasPrevious);
    }

    @Override
    public int createBook(BookCreateRequest bookCreateRequest) {

        MultipartFile bookImage = bookCreateRequest.getImage();

        String bookImageFileName = null;
        boolean isSaveImageSuccess = true;

        if(bookImage != null){
            bookImageFileName = FileUtils.formatNameImage(bookImage);
            isSaveImageSuccess = FileUtils.saveImageToServer(
                    request, BookConstant.UPLOAD_FILE_DIR, bookCreateRequest.getImage(), bookImageFileName);
        }

        if(isSaveImageSuccess){
            Book book = bookConverter.toEntity(bookCreateRequest, bookImageFileName);
            try {
                bookMapper.createBook(book);
                return 1;
            } catch (Exception e){
                FileUtils.deleteImageFromServer(request, BookConstant.UPLOAD_FILE_DIR, bookImageFileName);
                return 0;
            }
        }
        return 0;
    }

    @Override
    public BookDetailResponse findById(String id) {
        return bookConverter.toDetailResponse(bookMapper.findById(id));
    }

    @Override
    public ShowBookResponse updateBook(BookUpdateRequest bookUpdateRequest) {

        if (bookMapper.findById(bookUpdateRequest.getId()) == null)
            throw new NotFoundException(MessageErrorUtils.notFound("id"));

        Book book = bookConverter.toEntity(bookUpdateRequest);
        try {
            bookMapper.updateBook(book);
        } catch (Exception e) {
            return null;
        }
        return bookConverter.toShowBookResponse(book);
    }

    @Override
    public int deleteBook(String id) {

        if (bookMapper.findById(id) == null)
            throw new NotFoundException(MessageErrorUtils.notFound("id"));

        return bookMapper.deleteBook(id);
    }
}
