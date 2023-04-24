package com.kinaboot.muscles.controller.common;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.mail.internet.MimeMessage;
import java.util.Random;

@Slf4j
@Controller
@RequestMapping("/")
public class MailController {
    @Autowired
    private JavaMailSender mailSender;

    public static String mailSend(String verifyCode, String setFrom, String toMail, String title, String content, JavaMailSender mailSender) {
        log.info("Mail 발송 컨트롤러");
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
        return verifyCode;
    }

    @GetMapping("mailCheck")
    @ResponseBody
    public String emailCheck(String email, String type) {
        log.info("인증번호 전송 진입 [email] : " + email);
        Random random = new Random();
        int verifyCode = random.nextInt(888888) + 111111;
        log.info("생성된 인증번호 : " + verifyCode);
        /* 이메일 발송 */
        String setFrom = "quietgong@naver.com";
        String toMail = email;
        String title = "";
        String content = "";
        if (type.equals("register")) {
            title = "머슬스 회원가입 인증 이메일 입니다.";
            content =
                    "머슬스 회원가입을 환영합니다."
                            + "<br><br>"
                            + "인증 번호는 " + "<strong>" + verifyCode + "</strong> 입니다.";

        } else if (type.equals("passwordFind")) {
            title = "머슬스 임시 비밀번호 발급 인증 이메일 입니다.";
            content =
                    "요청하신 인증 번호는 " + "<strong>" + verifyCode + "</strong> 입니다.";
        }
        return mailSend(String.valueOf(verifyCode), setFrom, toMail, title, content, mailSender);
    }

}
