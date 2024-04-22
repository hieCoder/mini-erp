package com.shsoftvina.erpshsoftvina.api;

import com.shsoftvina.erpshsoftvina.model.request.tag.TagCreateRequest;
import com.shsoftvina.erpshsoftvina.model.request.tag.TagUpdateRequest;
import com.shsoftvina.erpshsoftvina.service.TagService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

@RestController
@RequestMapping("/api/v1/tags")
public class TagApi {

    @Autowired
    private TagService tagService;

    @GetMapping("")
    public ResponseEntity<?> findAll() {
        return ResponseEntity.ok(tagService.findAll());
    }

    @PostMapping("/createTag")
    public ResponseEntity<?> createTag(@Valid @RequestBody TagCreateRequest tagCreateRequest) {
        return ResponseEntity.ok(tagService.createTag(tagCreateRequest));
    }

    @PostMapping("/updation")
    public ResponseEntity<?> updateTag(@Valid @RequestBody TagUpdateRequest tagUpdateRequest) {
        return ResponseEntity.ok(tagService.updateTag(tagUpdateRequest));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteBook(@PathVariable String id) {
        return ResponseEntity.ok(tagService.deleteTag(id));
    }
}
