package com.kinaboot.muscles.controller;

import com.kinaboot.muscles.domain.CommentDto;
import com.kinaboot.muscles.service.CommentService;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;
@Slf4j
@RestController
@RequestMapping("/comments")
public class CommentController {
    @Autowired
    CommentService commentService;

    @GetMapping("")
    public ResponseEntity<List<CommentDto>> commentList(Integer postNo) throws Exception {
        log.info("댓글 목록 출력");
        return new ResponseEntity<>(commentService.findComments(postNo), HttpStatus.OK);
    }

    @PostMapping("")
    public ResponseEntity<String> commentAdd(@RequestBody CommentDto commentDto) throws Exception {
        log.info("댓글 작성");
        commentService.addComment(commentDto);
        return new ResponseEntity<>("WRT_OK", HttpStatus.OK);
    }

    @PatchMapping("")
    public ResponseEntity<String> commentModify(@RequestBody CommentDto commentDto) {
        log.info("댓글 수정");
        try {
            commentService.modifyComment(commentDto);
            return new ResponseEntity<>("MOD_OK", HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>("MOD_FAIL", HttpStatus.OK);
        }
    }

    @DeleteMapping("{commentNo}")
    public ResponseEntity<String> commentRemove(@PathVariable Integer commentNo) {
        log.info("댓글 삭제");
        try {
            commentService.removeComment(commentNo);
            return new ResponseEntity<>("DEL_OK", HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>("DEL_FAIL", HttpStatus.OK);
        }
    }
}
