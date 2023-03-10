package com.kinaboot.muscles.controller;

import com.kinaboot.muscles.dao.PostDao;
import com.kinaboot.muscles.dao.ReviewDao;
import com.kinaboot.muscles.dao.UserDao;
import com.kinaboot.muscles.domain.PostDto;
import com.kinaboot.muscles.domain.ReviewDto;
import com.kinaboot.muscles.domain.UserDto;
import com.kinaboot.muscles.service.ReviewService;
import com.kinaboot.muscles.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/mypage")
public class MypageController {
    private final UserDao userDao;
    MypageController(UserDao userDao) {
        this.userDao = userDao;
    }
    @Autowired
    UserService userService;
    @Autowired
    PostDao postDao;
    @Autowired
    ReviewService reviewService;

    @DeleteMapping("/myreview/delete")
    @ResponseBody
    public ResponseEntity<String> deleteReview(Integer orderNo, Integer productNo, HttpSession session){
        String userId = (String) session.getAttribute("id");
        reviewService.removeReview(orderNo, productNo, userId);
        return new ResponseEntity<>("DEL_OK", HttpStatus.OK);
    }
    // 내가 쓴 리뷰
    @GetMapping("/myreview/get")
    @ResponseBody
    public ResponseEntity<List<ReviewDto>> getReview(HttpSession session) {
        String userId = (String) session.getAttribute("id");
        List<ReviewDto> reviewDtoList = reviewService.getReviewListById(userId);
        return new ResponseEntity<>(reviewDtoList, HttpStatus.OK);
    }

    @GetMapping("/myreview")
    public String myreview(){
        return "mypage/myreview";
    }



    // 내가 쓴 글
    @GetMapping("/mypost")
    public String myPost(Model m, HttpSession session, HttpServletRequest request) throws Exception {
        String userId = (String) session.getAttribute("id");
        if (userId == null)
            return "redirect:/login?toURL=" + request.getRequestURL();
        List<PostDto> myPost = postDao.selectAllByUser(userId);
        m.addAttribute("list", myPost);
        return "mypage/mypost";
    }

    // 사용자 정보 변경
    @PostMapping("/modinfo")
    public String modInfoPost(Model m, HttpSession session, HttpServletRequest request) throws Exception {
        String userId = (String) session.getAttribute("id");
        String userNewEmail = request.getParameter("newEmail");
        String userNewPhone = request.getParameter("newPhone");
        String[] userInfo = {userId, userNewEmail, userNewPhone};
        userService.modifyUserInfo(userInfo);
        session.invalidate();
        return "redirect:/";
    }

    @GetMapping("/modinfo")
    public String modinfoGet(Model m, HttpSession session, HttpServletRequest request) throws Exception {
        String userId = (String) session.getAttribute("id");
        UserDto userDto = userDao.selectUser(userId);
        m.addAttribute("user", userDto);
        return "mypage/modinfo";
    }


    // 비밀번호 변경
    @PostMapping("/modpw")
    public String modpwPost(HttpSession session, HttpServletRequest request) throws Exception {
        String userId = (String) session.getAttribute("id");
        UserDto userDto = userService.read(userId);
        String nowPassword = request.getParameter("nowPassword");
        String newPassword = request.getParameter("newPassword1");

        String msg = URLEncoder.encode("Password가 일치하지 않습니다.", "utf-8");
        if (!userDto.getPassword().equals(nowPassword))
            return "redirect:/mypage/modpw?msg=" + msg;
        // 새로운 비밀번호로 변경
        userService.modifyUserPassword(userId, newPassword);
        session.invalidate();
        return "redirect:/";
    }

    @GetMapping("/modpw")
    public String modpwGet(Model m, HttpSession session, HttpServletRequest request) throws Exception {
        String userId = (String) session.getAttribute("id");
        if (userId == null)
            return "redirect:/login?toURL=" + request.getRequestURL();
        return "mypage/modpw";
    }

    // 회원 탈퇴
    @PostMapping("/leave")
    public String leavePost(Model m, HttpSession session, HttpServletRequest request) throws Exception {
        String userId = (String) session.getAttribute("id");
        int[] typeValue = new int[]{0, 0, 0};
        String[] type = request.getParameterValues("type");
        String opinion = request.getParameter("opinion");
        for (String s : type)
            typeValue[Integer.parseInt(s) - 1]++;
        Map map = new HashMap();
        map.put("userId", userId);
        map.put("type1", String.valueOf(typeValue[0]));
        map.put("type2", String.valueOf(typeValue[1]));
        map.put("type3", String.valueOf(typeValue[2]));
        map.put("opinion", opinion);
        userService.leaveUser(map);
        session.invalidate();
        return "redirect:/";
    }

    @GetMapping("/leave")
    public String leaveGet(Model m, HttpSession session, HttpServletRequest request) throws Exception {
        String userId = (String) session.getAttribute("id");
        if (userId == null)
            return "redirect:/login?toURL=" + request.getRequestURL();
        List<PostDto> myPost = postDao.selectAllByUser(userId);
        m.addAttribute("list", myPost);
        return "mypage/leave";
    }

}
