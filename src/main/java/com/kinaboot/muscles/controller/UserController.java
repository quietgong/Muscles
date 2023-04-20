package com.kinaboot.muscles.controller;

import com.kinaboot.muscles.domain.ExitDto;
import com.kinaboot.muscles.domain.PostDto;
import com.kinaboot.muscles.domain.ReviewDto;
import com.kinaboot.muscles.domain.UserDto;
import com.kinaboot.muscles.handler.SearchCondition;
import com.kinaboot.muscles.service.PostSerivce;
import com.kinaboot.muscles.service.ReviewService;
import com.kinaboot.muscles.service.UserService;
import lombok.extern.slf4j.Slf4j;
import org.apache.catalina.User;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.net.URLEncoder;
import java.util.List;
@Slf4j
@RestController
@RequestMapping("/mypage")
public class UserController {
    @Autowired
    ReviewService reviewService;
    @Autowired
    UserService userService;
    @Autowired
    PostSerivce postSerivce;
    @Autowired
    BCryptPasswordEncoder passwordEncoder;

    @GetMapping("/user/{userId}")
    public ResponseEntity<UserDto> userDetails(@PathVariable String userId) throws Exception {
        log.info("회원정보 수정");
        return new ResponseEntity<>(userService.findUser(userId), HttpStatus.OK);
    }

    @GetMapping("/post/{userId}")
    public ResponseEntity<List<PostDto>> postList(@PathVariable String userId) throws Exception {
        log.info("내가 쓴 글 조회");
        return new ResponseEntity<>(postSerivce.findPosts(userId), HttpStatus.OK);
    }

    @GetMapping("/review/{userId}")
    public ResponseEntity<List<ReviewDto>> reviewList(@PathVariable String userId) {
        log.info("내가 쓴 리뷰 조회");
        return new ResponseEntity<>(reviewService.findReviews(userId), HttpStatus.OK);
    }

    @PostMapping("/modify/")
    public ResponseEntity<String> userModify(UserDto newUserDto, HttpSession session) {
        log.info("[id] : " + newUserDto.getUserId() + " 회원 정보 변경");
        try {
            userService.modifyUser(newUserDto);
            session.invalidate();
            return new ResponseEntity<>("MOD_OK", HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>("MOD_FAIL", HttpStatus.OK);
        }
    }

    @PostMapping("/exit/")
    public ResponseEntity<String> exitAdd(@RequestBody ExitDto exitDto, HttpSession session) {
        log.info("[id] : " + exitDto.getUserId() + " 회원탈퇴");
        try {
            userService.removeUser(exitDto, "user");
            session.invalidate();
            return new ResponseEntity<>("DEL_OK", HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>("DEL_FAIL", HttpStatus.OK);
        }
    }
}
