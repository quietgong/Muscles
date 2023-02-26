package com.kinaboot.muscles.controller;

import com.kinaboot.muscles.dao.UserDao;
import com.kinaboot.muscles.domain.UserDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.net.URLEncoder;

@Controller
public class LoginController {
    private final UserDao userDao;

    LoginController(UserDao userDao) {
        this.userDao = userDao;
    }

    @GetMapping("/login")
    public String login() {
        return "login";
    }
    @PostMapping("/login")
    public String login(String toURL, UserDto userDto, HttpServletResponse response, HttpServletRequest request, boolean rememberId) throws Exception {
        String msg = URLEncoder.encode("id 또는 pwd가 일치하지 않습니다.", "utf-8");
        if (!loginCheck(userDto.getId(), userDto.getPassword())) { // 로그인이 안되면
            return "redirect:/login?msg=" + msg;
        }
        // 로그인 성공이 하면 세션과 쿠키를 생성한다.
        HttpSession session = request.getSession();
        session.setAttribute("id", userDto.getId());
        Cookie cookie = new Cookie("id", userDto.getId());
        // 아이디 저장이 체크 해제되어있으면 쿠키를 해제한다.
        if (!rememberId) cookie.setMaxAge(0);
        response.addCookie(cookie);
        // toURL이 빈 문자열이거나 홈으로, 그렇지 않으면 가고자했던 URL로 대입
        toURL = toURL == null || toURL.equals("") ? "/" : toURL;

        return "redirect:" + toURL;
    }
    private boolean loginCheck(String id, String pw) {
        if (userDao.searchIdCnt(id) != 0) {
            UserDto userDto = userDao.selectUser(id);
            return userDto.getPassword().equals(pw);
        }
        return false;
    }
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }
}
