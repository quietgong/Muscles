package com.kinaboot.muscles.controller;

import com.kinaboot.muscles.domain.UserDto;
import com.kinaboot.muscles.service.CartService;
import com.kinaboot.muscles.service.UserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.net.URLEncoder;
import java.security.SecureRandom;

import static com.kinaboot.muscles.controller.common.MailController.mailSend;

@Slf4j
@Controller
public class LoginController {
    private final BCryptPasswordEncoder passwordEncoder;
    private final UserService userService;
    private final CartService cartService;
    private final JavaMailSender mailSender;
    @Autowired
    public LoginController(BCryptPasswordEncoder passwordEncoder, UserService userService, CartService cartService, JavaMailSender mailSender) {
        this.passwordEncoder = passwordEncoder;
        this.userService = userService;
        this.cartService = cartService;
        this.mailSender = mailSender;
    }

    @PostMapping("/login/")
    public String login(String toURL, UserDto userDto, HttpServletResponse response, HttpServletRequest request, boolean rememberId) throws Exception {
        log.info("로그인 진입");
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

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        log.info("로그아웃 진입");
        session.invalidate();
        return "redirect:/";
    }

    @GetMapping("/emailExistCheck")
    @ResponseBody
    public ResponseEntity<String> emailExistCheck(String email) {
        log.info("[email : " + email + "] 중복 검사 ");
        try {
            return new ResponseEntity<>(userService.findUserEmail(email).getUserId(), HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>("invalid", HttpStatus.OK);
        }
    }


    private boolean loginCheck(String id, String pw) {
        try {
            return passwordEncoder.matches(pw, userService.findUser(id).getPassword()) && userService.findUser(id).getExpiredDate() == null;
        } catch (Exception e) {
            return false;
        }
    }

    @PostMapping("/passwordReset")
    public String passwordReset(String email, RedirectAttributes rttr) {
        log.info("임시 비밀번호 발송 진입 [email] : " + email);
        String resetPassword = generateRandomString();
        String userId = userService.findUserEmail(email).getUserId();
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
        rttr.addFlashAttribute("email", email);
        return "redirect:/pwfind";
    }
    @GetMapping("/pwfind")
    public String resetPassword(){
        log.info("비밀번호 초기화");
        return "resetpwd";
    }

    private String generateRandomString() {
        // 알파벳과 숫자를 조합한 임의의 6자리 문자열 생성
        int length = 6;
        String ALPHANUMERIC_CHARS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        SecureRandom random = new SecureRandom();

        StringBuilder sb = new StringBuilder(length);
        for (int i = 0; i < length; i++)
            sb.append(ALPHANUMERIC_CHARS.charAt(random.nextInt(ALPHANUMERIC_CHARS.length())));
        return sb.toString();
    }
}
