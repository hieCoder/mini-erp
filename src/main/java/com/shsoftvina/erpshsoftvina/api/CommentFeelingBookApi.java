package com.shsoftvina.erpshsoftvina.api;

import com.shsoftvina.erpshsoftvina.model.request.commentFeelingBook.CreateCommentFeelingBookRequest;
import com.shsoftvina.erpshsoftvina.model.request.commentFeelingBook.UpdateCommentFeelingBookRequest;
import com.shsoftvina.erpshsoftvina.model.response.commentfeelingbook.CommentFeelingBookResponse;
import com.shsoftvina.erpshsoftvina.service.CommentFeelingBookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

@RestController
@RequestMapping("/api/v1/comment-feeling-Book")
public class CommentFeelingBookApi {

    @Autowired
    private CommentFeelingBookService commentFeelingBookService;

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
