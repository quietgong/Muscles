package com.kinaboot.muscles.controller.mypage;

import com.kinaboot.muscles.domain.ReviewDto;
import com.kinaboot.muscles.domain.UserDto;
import com.kinaboot.muscles.handler.SearchCondition;
import com.kinaboot.muscles.service.PostSerivce;
import com.kinaboot.muscles.service.ReviewService;
import com.kinaboot.muscles.service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.net.URLEncoder;
import java.util.List;
@Controller
@RequestMapping("/mypage/")
public class UserController {
    private static final Logger logger = LoggerFactory.getLogger(UserController.class);
    @Autowired
    ReviewService reviewService;
    @Autowired
    UserService userService;
    @Autowired
    PostSerivce postSerivce;

    @GetMapping("/review/{userId}")
    @ResponseBody
    public ResponseEntity<List<ReviewDto>> reviewList(@PathVariable String userId) {
        logger.info("내가 쓴 리뷰 조회");
        return new ResponseEntity<>(reviewService.findReviews(userId), HttpStatus.OK);
    }

    @PostMapping("/post/{userId}")
    public String postList(Model m, @PathVariable String userId) throws Exception {
        logger.info("내가 쓴 글 조회");
        m.addAttribute("list", postSerivce.findPosts(userId, new SearchCondition()));
        return "mypage/mypost";
    }

    @GetMapping("/modify")
    public String userModify(Model m, HttpSession session) throws Exception {
        logger.info("사용자 정보 변경 진입");
        String userId = (String) session.getAttribute("id");
        m.addAttribute("userDto", userService.findUser(userId));
        return "mypage/myinfo";
    }

    @PostMapping("/modify")
    public String userModify(UserDto userDto,HttpSession session, HttpServletRequest request) throws Exception {
        String nowPassword = request.getParameter("nowPassword");
        String newPassword = request.getParameter("newPassword1");

        String msg = URLEncoder.encode("Password가 일치하지 않습니다.", "utf-8");
        if (!userDto.getPassword().equals(nowPassword))
            return "redirect:/mypage/myinfo?msg=" + msg;

        userService.modifyUser(userDto);
        session.invalidate();
        return "redirect:/";
    }

    @GetMapping("/exit")
    public String exitDetails(Model m, HttpSession session) throws Exception {
        logger.info("회원탈퇴 페이지 진입");
        String userId = (String) session.getAttribute("id");
        m.addAttribute("list", userService.findUser(userId));
        return "mypage/exit";
    }

    @PostMapping("/exit")
    public String exitAdd(HttpServletRequest request, HttpSession session) throws Exception {
        String userId = (String) session.getAttribute("id");
        logger.info("[id] : " + userId + " 회원탈퇴");

        userService.removeUser(userService.findUser(userId).getUserNo(), request, "user");
        session.invalidate();
        return "redirect:/";
    }
}
