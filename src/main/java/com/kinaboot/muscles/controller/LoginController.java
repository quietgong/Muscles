package com.kinaboot.muscles.controller;

import com.kinaboot.muscles.dao.UserDao;
import com.kinaboot.muscles.domain.UserDto;
import com.kinaboot.muscles.service.CartService;
import com.kinaboot.muscles.service.UserService;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.net.URLEncoder;
import java.util.Random;

import static com.kinaboot.muscles.controller.common.MailController.mailSend;
@Slf4j
@Controller
public class LoginController {
    @Autowired
    private BCryptPasswordEncoder passwordEncoder;

    @Autowired
    UserService userService;

    @Autowired
    CartService cartService;

    @Autowired
    private JavaMailSender mailSender;

    @PostMapping("/login/")
    public String login(String toURL, UserDto userDto, HttpServletResponse response, HttpServletRequest request, boolean rememberId) throws Exception {
        String msg = URLEncoder.encode("id 또는 pwd가 일치하지 않습니다.", "utf-8");
        if (!loginCheck(userDto.getUserId(), userDto.getPassword())) {
            // 로그인에 실패 : 가고자 했던 경로를 URL에 저장한다.
            return "redirect:/login?msg=" + msg + "&toURL=" + toURL;
        }
        // 로그인 성공 : 세션, 쿠키 생성
        HttpSession session = request.getSession();
        session.setAttribute("id", userDto.getUserId());
        session.setAttribute("cartNum", cartService.findCartItems(userDto.getUserId()).size());
        Cookie cookie = new Cookie("id", userDto.getUserId());

        // 아이디 저장이 체크 해제되어있으면 쿠키를 해제한다.
        if (!rememberId) cookie.setMaxAge(0);
        response.addCookie(cookie);

        // toURL이 빈 문자열이거나 홈으로, 그렇지 않으면 가고자했던 URL로 대입
        toURL = toURL == null || toURL.equals("") ? "/" : toURL;
        return "redirect:" + toURL;
    }

    private boolean loginCheck(String id, String pw) throws Exception {
        UserDto userDto = null;
        try {
            userDto = userService.findUser(id);
            String encodingPw = userDto.getPassword();
            return passwordEncoder.matches(pw, encodingPw) && userService.findUser(id).getExpiredDate() == null;
        } catch (Exception e) {
            return false;
        }
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        log.info("로그아웃 진입");
        session.invalidate();
        return "redirect:/";
    }

    @GetMapping("/test")
    public String test(){
        return "pwdfindcomplete";
    }

    @GetMapping("/emailExistCheck")
    @ResponseBody
    public ResponseEntity<String> emailExistCheck(String email) {
        try {
            return new ResponseEntity<>(userService.findUserEmail(email).getUserId(), HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>("invalid", HttpStatus.OK);
        }
    }

    @PostMapping("/passwordReset")
    public String passwordReset(String userId, String email, Model m) {
        log.info("임시 비밀번호 발송 진입 [email] : " + email);
        String resetPassword = generateRandomString();
        userService.resetPassword(userId, passwordEncoder.encode(resetPassword));
        log.info("생성된 임시 비밀번호 : " + resetPassword);
        /* 이메일 발송 */
        String setFrom = "quietgong@naver.com";
        String toMail = email;
        String title = "머슬스 임시 비밀번호 발송 이메일 입니다.";
        String content =
                "안녕하세요. 머슬스입니다.<br><br>"
                        +
                        "요청하신 임시 비밀번호는 <strong>" + resetPassword + "</strong> 입니다.";

        mailSend(resetPassword, setFrom, toMail, title, content, mailSender);
        m.addAttribute("email", email);
        return "pwdfindcomplete";
    }

    private String generateRandomString() {
        Random random = new Random();
        int letterLen = 4;
        int numLen = 2;

        StringBuilder sb = new StringBuilder(letterLen + numLen);

        int letterMin = 65; // ASCII code : 'A'
        int letterMax = 90; // ASCII code : 'Z'

        for (int i = 0; i < letterLen; i++) {
            int asciiValue = random.nextInt((letterMax - letterMin) + 1) + letterMin;
            char ch = (char) asciiValue;
            sb.append(ch);
        }

        int numberMin = 48; // ASCII code : '0'
        int numberMax = 57; // ASCII code : '9'

        for (int i = 0; i < numLen; i++) {
            int asciiValue = random.nextInt((numberMax - numberMin) + 1) + numberMin;
            char ch = (char) asciiValue;
            sb.append(ch);
        }
        return sb.toString();
    }
}
