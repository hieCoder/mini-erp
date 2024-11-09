package com.hieDev.minierp.api;

import com.hieDev.minierp.model.request.commentFeelingBook.CreateCommentFeelingBookRequest;
import com.hieDev.minierp.model.request.commentFeelingBook.UpdateCommentFeelingBookRequest;
import com.hieDev.minierp.model.response.commentfeelingbook.CommentFeelingBookResponse;
import com.hieDev.minierp.service.CommentFeelingBookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

@RestController
@RequestMapping("/api/v1/comment-feeling-book")
public class CommentFeelingBookApi {

    @Autowired
    private CommentFeelingBookService commentFeelingBookService;

    @GetMapping("/{id}")
    public ResponseEntity<?> findById(@PathVariable("id") String id) {
        CommentFeelingBookResponse commentFeelingBookResponse = commentFeelingBookService.findById(id);
        if (commentFeelingBookResponse != null) return ResponseEntity.ok(commentFeelingBookResponse);
        return ResponseEntity.badRequest().build();
    }

    @PostMapping
    public ResponseEntity<?> createCommentFeeling(@Valid @RequestBody CreateCommentFeelingBookRequest createCommentFeelingBookRequest) {
        CommentFeelingBookResponse commentFeelingBookResponse = commentFeelingBookService.createCommentFeeling(createCommentFeelingBookRequest);
        if (commentFeelingBookResponse != null) return ResponseEntity.ok(commentFeelingBookResponse);
        return ResponseEntity.badRequest().build();
    }

    @PutMapping
    public ResponseEntity<?> updateCommentFeeling(@Valid @RequestBody UpdateCommentFeelingBookRequest updateCommentFeelingBookRequest) {
        CommentFeelingBookResponse commentFeelingBookResponse = commentFeelingBookService.updateCommentFeeling(updateCommentFeelingBookRequest);
        if (commentFeelingBookResponse != null) return ResponseEntity.ok(commentFeelingBookResponse);
        return ResponseEntity.badRequest().build();
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteCommentFeeling(@PathVariable("id") String id) {
        int deleteCommnetFeeling = commentFeelingBookService.deleteById(id);
        if (deleteCommnetFeeling != 0) return ResponseEntity.ok(deleteCommnetFeeling);
        return ResponseEntity.badRequest().build();
    }
}
