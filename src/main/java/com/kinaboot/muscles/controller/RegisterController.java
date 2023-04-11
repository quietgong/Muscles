package com.kinaboot.muscles.controller;

import com.kinaboot.muscles.dao.UserDao;
import com.kinaboot.muscles.domain.UserDto;
import com.kinaboot.muscles.service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import java.net.URLEncoder;
import java.util.Random;

@Controller
@RequestMapping("/register/")
public class RegisterController {
    private static final Logger logger = LoggerFactory.getLogger(RegisterController.class);

    @Autowired
    private JavaMailSender mailSender;

    @Autowired
    private BCryptPasswordEncoder passwordEncoder;
    @Autowired
    UserService userService;

    @PostMapping("")
    public String registerDetails(UserDto userDto) throws Exception {
        logger.info("회원가입 진입");
        String id = userDto.getUserId();
        if (userService.findUser(id) != null)
            return "redirect:/?msg=" + URLEncoder.encode("중복된 아이디입니다.", "UTF-8");
        String originPw = "";
        String encodingPw = "";

        originPw = userDto.getPassword();
        encodingPw = passwordEncoder.encode(originPw);
        userDto.setPassword(encodingPw);

        userService.addUser(userDto);

        logger.info("ID : " + userDto.getUserId() + "생성 성공");
        return "redirect:/";
    }

    @GetMapping("idDupCheck/{userId}")
    @ResponseBody
    public int idDupCheck(@PathVariable String userId) {
        logger.info("ID 중복검사 [id] : " + userId);
        return userService.countUser(userId);
    }

    @GetMapping("mailCheck")
    @ResponseBody
    public String emailCheck(String email) {
        logger.info("인증번호 전송 진입 [email] : " + email);
        /* 인증번호 생성 */
        Random random = new Random();
        int verifyNum = random.nextInt(888888) + 111111;
        logger.info("생성된 인증번호 : " + verifyNum);
        /* 이메일 발송 */
        String setFrom = "quietgong@naver.com";
        String toMail = email;
        String title = "머슬스 회원가입 인증 이메일 입니다.";
        String content =
                "머슬스 회원가입을 환영합니다."
                        + "<br><br>"
                        + "인증 번호는 " + "<strong>" + verifyNum + "</strong> 입니다.";

        /* 발송 */
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
            helper.setFrom(setFrom);
            helper.setTo(toMail);
            helper.setSubject(title);
            helper.setText(content, true);
            mailSender.send(message);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return String.valueOf(verifyNum);
    }
}
