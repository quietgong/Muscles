package com.kinaboot.muscles.controller.common;

import lombok.extern.slf4j.Slf4j;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;

import javax.mail.internet.MimeMessage;
@Slf4j
@Controller
public class MailController {

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
}
