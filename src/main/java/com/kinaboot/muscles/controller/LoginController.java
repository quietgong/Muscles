package com.kinaboot.muscles.controller;

import com.kinaboot.muscles.dao.UserDao;
import com.kinaboot.muscles.domain.UserDto;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.net.URLEncoder;

@Controller
public class LoginController {
    @Autowired
    private BCryptPasswordEncoder passwordEncoder;
    private static final Logger logger = LoggerFactory.getLogger(LoginController.class);

    private final UserDao userDao;

    LoginController(UserDao userDao) {
        this.userDao = userDao;
    }

    /* 로그인 화면 출력 */
    @GetMapping("/login")
    public String login() {
        return "login";
    }

    @PostMapping("/login")
    public String login(String toURL, UserDto userDto, HttpServletResponse response, HttpServletRequest request, boolean rememberId) throws Exception {
        String msg = URLEncoder.encode("id 또는 pwd가 일치하지 않습니다.", "utf-8");
        if (!loginCheck(userDto.getUserId(), userDto.getPassword())) {
            // 로그인에 실패 : 가고자 했던 경로를 URL에 저장한다.
            return "redirect:/login?msg=" + msg +"&toURL=" + toURL;
        }
        // 로그인 성공 : 세션, 쿠키 생성
        HttpSession session = request.getSession();
        session.setAttribute("id", userDto.getUserId());
        Cookie cookie = new Cookie("id", userDto.getUserId());

        // 아이디 저장이 체크 해제되어있으면 쿠키를 해제한다.
        if (!rememberId) cookie.setMaxAge(0);
        response.addCookie(cookie);

        // toURL이 빈 문자열이거나 홈으로, 그렇지 않으면 가고자했던 URL로 대입
        toURL = toURL == null || toURL.equals("") ? "/" : toURL;
        return "redirect:" + toURL;
    }
    private boolean loginCheck(String id, String pw) {
        String encodingPw = userDao.selectUser(id).getPassword();
        if (userDao.selectUser(id) != null)
            return passwordEncoder.matches(pw, encodingPw);
        return false;
    }
    @GetMapping("/logout")
    @ResponseBody
    public void logout(HttpSession session) {
        logger.info("로그아웃 진입");

        session.invalidate();
    }
}
