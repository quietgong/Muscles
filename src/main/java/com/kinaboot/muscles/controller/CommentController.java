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

@Controller
@RestController
public class CommentController {
    private static final Logger logger = LoggerFactory.getLogger(CommentController.class);

    @Autowired
    CommentService commentService;

    // 선택한 게시물의 댓글 가져오기
    @GetMapping("/comments")
    public ResponseEntity<List<CommentDto>> list(Integer postNo) throws Exception {
        logger.info("댓글 목록 출력");
        return new ResponseEntity<>(commentService.getList(postNo), HttpStatus.OK);
    }
    // 댓글 등록
    @PostMapping("/comments/")
    public ResponseEntity<String> write(@RequestBody CommentDto commentDto) throws Exception {
        commentService.write(commentDto);
        return new ResponseEntity<>("WRT_OK", HttpStatus.OK);
    }
    // 댓글 삭제
    @DeleteMapping("/comments/{commentNo}")
    public ResponseEntity<String> remove(@PathVariable Integer commentNo) throws Exception {
        try {
            commentService.remove(commentNo);
            return new ResponseEntity<>("DEL_OK", HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>("DEL_FAIL", HttpStatus.OK);
        }
    }
    // 댓글 수정
    @PatchMapping("/comments/{commentNo}")
    public ResponseEntity<String> modify(@PathVariable Integer commentNo, @RequestBody CommentDto commentDto, HttpSession session) throws Exception {
        String userId = (String) session.getAttribute("id");
        commentDto.setUserId(userId);
        commentDto.setCommentNo(commentNo);
        commentService.modify(commentDto);
        return new ResponseEntity<>("MOD_OK", HttpStatus.OK);
    }
}
