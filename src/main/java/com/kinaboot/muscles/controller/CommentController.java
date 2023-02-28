package com.kinaboot.muscles.controller;

import com.kinaboot.muscles.domain.CommentDto;
import com.kinaboot.muscles.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class CommentController {
    @Autowired
    CommentService commentService;

    // 선택한 게시물의 댓글 모두 가져오기
    @GetMapping("/comments")
    public ResponseEntity<List<CommentDto>> list(Integer postNo) throws Exception {
        List<CommentDto> commentDtoList = commentService.getList(postNo);
        System.out.println("read called");
        return new ResponseEntity<>(commentDtoList, HttpStatus.OK);
    }

    // 선택한 댓글 삭제
    @DeleteMapping("/comments/{commentNo}") // /comments/1?postNo=12
    public ResponseEntity<String> remove(@PathVariable Integer commentNo, Integer postNo, HttpSession session) throws Exception {
        String userId = (String) session.getAttribute("id");
        commentService.remove(commentNo, postNo, userId);
        return new ResponseEntity<>("DEL_OK", HttpStatus.OK);
    }

    // 댓글 등록
    @PostMapping("/comments")
    @ResponseBody
    public ResponseEntity<String> write(@RequestBody CommentDto commentDto, Integer postNo, HttpSession session) throws Exception {
        String userId = (String) session.getAttribute("id");
        commentDto.setUserId(userId);
        commentDto.setPostNo(postNo);
        System.out.println("write called");
        commentService.write(commentDto);
        return new ResponseEntity<>("WRT_OK", HttpStatus.OK);
    }

    // 댓글 수정
    @PatchMapping("/comments/{commentNo}")
    @ResponseBody public ResponseEntity<String> modify(@PathVariable Integer commentNo, @RequestBody CommentDto commentDto, HttpSession session) throws Exception {
        String userId = (String) session.getAttribute("id");
        commentDto.setUserId(userId);
        commentDto.setCommentNo(commentNo);

        System.out.println("modify called");
        commentService.modify(commentDto);
        return new ResponseEntity<>("MOD_OK", HttpStatus.OK);
    }
}
