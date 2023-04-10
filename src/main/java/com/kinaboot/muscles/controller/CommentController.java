package com.kinaboot.muscles.controller;

import com.kinaboot.muscles.domain.CommentDto;
import com.kinaboot.muscles.service.CommentService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

@RestController
@RequestMapping("/comments/")
public class CommentController {
    private static final Logger logger = LoggerFactory.getLogger(CommentController.class);

    @Autowired
    CommentService commentService;

    @GetMapping("")
    public ResponseEntity<List<CommentDto>> commentList(Integer postNo) throws Exception {
        logger.info("댓글 목록 출력");
        return new ResponseEntity<>(commentService.findComments(postNo), HttpStatus.OK);
    }
    @PostMapping("")
    public ResponseEntity<String> commentAdd(@RequestBody CommentDto commentDto) throws Exception {
        commentService.addComment(commentDto);
        return new ResponseEntity<>("WRT_OK", HttpStatus.OK);
    }
    @DeleteMapping("{commentNo}")
    public ResponseEntity<String> commentRemove(@PathVariable Integer commentNo) throws Exception {
        try {
            commentService.removeComment(commentNo);
            return new ResponseEntity<>("DEL_OK", HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>("DEL_FAIL", HttpStatus.OK);
        }
    }
    @PatchMapping("")
    public ResponseEntity<String> commentModify(@RequestBody CommentDto commentDto) throws Exception {
        commentService.modifyComment(commentDto);
        return new ResponseEntity<>("MOD_OK", HttpStatus.OK);
    }
}
