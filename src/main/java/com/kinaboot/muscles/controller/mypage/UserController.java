package com.kinaboot.muscles.controller.mypage;

import com.kinaboot.muscles.domain.PostDto;
import com.kinaboot.muscles.domain.ReviewDto;
import com.kinaboot.muscles.domain.UserDto;
import com.kinaboot.muscles.handler.SearchCondition;
import com.kinaboot.muscles.service.PostSerivce;
import com.kinaboot.muscles.service.ReviewService;
import com.kinaboot.muscles.service.UserService;
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

@Controller
@RequestMapping("/mypage")
public class UserController {
    private static final Logger logger = LoggerFactory.getLogger(UserController.class);
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
        logger.info("유저 단건 조회");
        return new ResponseEntity<>(userService.findUser(userId), HttpStatus.OK);
    }
    @GetMapping("/post/{userId}")
    @ResponseBody
    public ResponseEntity<List<PostDto>> postList(@PathVariable String userId) throws Exception {
        logger.info("내가 쓴 글 조회");
        return new ResponseEntity<>(postSerivce.findPosts(userId), HttpStatus.OK);
    }
    @GetMapping("/review/{userId}")
    @ResponseBody
    public ResponseEntity<List<ReviewDto>> reviewList(@PathVariable String userId) {
        logger.info("내가 쓴 리뷰 조회");
        return new ResponseEntity<>(reviewService.findReviews(userId), HttpStatus.OK);
    }


    @PostMapping("/modify/")
    public String userModify(UserDto newUserDto, HttpSession session, HttpServletRequest request) throws Exception {
        String userId = (String) session.getAttribute("id");
        logger.info("[id] : " + userId + " 회원 정보 변경");
        String originPassword = userService.findUser(userId).getPassword();
        String nowPassword = request.getParameter("nowPassword");
        String newPassword = passwordEncoder.encode(request.getParameter("newPassword"));

        String msg = URLEncoder.encode("Password가 일치하지 않습니다.", "utf-8");
        // 입력한 비밀번호와 유저의 비밀번호가 다를 때
        if (!passwordEncoder.matches(nowPassword, originPassword))
            return "redirect:/mypage/modify?msg=" + msg;
        newUserDto.setPassword(newPassword);
        userService.modifyUser(newUserDto);
        session.invalidate();
        return "redirect:/";
    }

    @PostMapping("/exit/")
    public String exitAdd(HttpServletRequest request, HttpSession session) throws Exception {
        String userId = (String) session.getAttribute("id");
        logger.info("[id] : " + userId + " 회원탈퇴");
        userService.removeUser(userId, request, "user");
        session.invalidate();
        return "redirect:/";
    }
}
