package com.hieDev.minierp.service.impl;

import com.hieDev.minierp.constant.BookConstant;
import com.hieDev.minierp.converter.BookConverter;
import com.hieDev.minierp.exception.NotFoundException;
import com.hieDev.minierp.entity.Book;
import com.hieDev.minierp.mapper.BookMapper;
import com.hieDev.minierp.model.request.book.BookCreateRequest;
import com.hieDev.minierp.model.request.book.BookUpdateRequest;
import com.hieDev.minierp.model.response.book.BookResponse;
import com.hieDev.minierp.service.BookService;
import com.hieDev.minierp.utils.ApplicationUtils;
import com.hieDev.minierp.utils.FileUtils;
import com.hieDev.minierp.utils.MessageErrorUtils;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Service
public class BookServiceImpl implements BookService {

    @Autowired
    private BookMapper bookMapper;

    @Autowired
    private BookConverter bookConverter;

    @Autowired
    private ApplicationUtils applicationUtils;

    @Override
    public List<BookResponse> findAll(String searchTerm, int start, int pageSize) {
        int offset = (start - 1) * pageSize;
        RowBounds rowBounds = new RowBounds(offset, pageSize);
        List<Book> books = bookMapper.findAll(searchTerm, rowBounds);
        return bookConverter.toListResponse(books);
    }

    @Override
    public long getTotalItem(String search) {
        return bookMapper.totalBook(search);
    }

    @Override
    public int createBook(BookCreateRequest bookCreateRequest) {

        MultipartFile bookImage = bookCreateRequest.getImage();

        String bookImageFileName = null;
        boolean isSaveImageSuccess = true;

        if(bookImage != null){

            applicationUtils.checkValidateImage(Book.class, bookImage);

            bookImageFileName = FileUtils.formatNameImage(bookImage);
            isSaveImageSuccess = FileUtils.saveImageToServer(BookConstant.UPLOAD_FILE_DIR, bookCreateRequest.getImage(), bookImageFileName);
        }

        if(isSaveImageSuccess){
            Book book = bookConverter.toEntity(bookCreateRequest, bookImageFileName);
            try {
                bookMapper.createBook(book);
                return 1;
            } catch (Exception e){
                FileUtils.deleteImageFromServer(BookConstant.UPLOAD_FILE_DIR, bookImageFileName);
                return 0;
            }
        }
        return 0;
    }

    @Override
    public BookResponse findById(String id) {
        return bookConverter.toResponse(bookMapper.findById(id));
    }

    @Override
    public int updateBook(BookUpdateRequest bookUpdateRequest) {

        Book book = bookMapper.findById(bookUpdateRequest.getId());

        if(book == null) throw new NotFoundException("id");

        MultipartFile bookFile = bookUpdateRequest.getImage();

        String fileNameBook = null, oldImage = book.getImage();
        boolean isSaveBookSuccess = true;

        if(bookFile != null){
            applicationUtils.checkValidateImage(Book.class, bookFile);

            fileNameBook = FileUtils.formatNameImage(bookFile);
            isSaveBookSuccess = FileUtils.saveImageToServer(BookConstant.UPLOAD_FILE_DIR, bookUpdateRequest.getImage(), fileNameBook);
        } else{
            fileNameBook = oldImage;
        }

        Book b;
        if(isSaveBookSuccess){
            b = bookConverter.toEntity(bookUpdateRequest, fileNameBook);
            try {
                bookMapper.updateBook(b);
                if(!fileNameBook.equals(oldImage)){
                    FileUtils.deleteImageFromServer(BookConstant.UPLOAD_FILE_DIR, oldImage);
                }
                return 1;
            } catch (Exception e){
                FileUtils.deleteImageFromServer(BookConstant.UPLOAD_FILE_DIR, fileNameBook);
                return 0;
            }
        }
        return 0;
    }

    @Override
    public int deleteBook(String id) {
        Book book = bookMapper.findById(id);
        if (book == null)  throw new NotFoundException(MessageErrorUtils.notFound("id"));
        FileUtils.deleteImageFromServer(BookConstant.UPLOAD_FILE_DIR, book.getImage());

        return bookMapper.deleteBook(id);
    }
}
