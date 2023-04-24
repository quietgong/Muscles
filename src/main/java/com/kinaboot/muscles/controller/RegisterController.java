package com.kinaboot.muscles.controller;

import com.kinaboot.muscles.domain.UserDto;
import com.kinaboot.muscles.service.UserService;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.net.URLEncoder;
import java.util.Random;

import static com.kinaboot.muscles.controller.common.MailController.mailSend;

@Slf4j
@Controller
@RequestMapping("/register/")
public class RegisterController {
    @Autowired
    private BCryptPasswordEncoder passwordEncoder;
    @Autowired
    UserService userService;

    @PostMapping("")
    public String registerDetails(UserDto userDto) throws Exception {
        log.info("회원가입 진입");
        if (userService.findUser(userDto.getUserId()) != null)
            return "redirect:/?msg=" + URLEncoder.encode("중복된 아이디입니다.", "UTF-8");
        userDto.setPassword(passwordEncoder.encode(userDto.getPassword()));
        userService.addUser(userDto);
        log.info("ID : " + userDto.getUserId() + "생성 성공");
        return "redirect:/";
    }

    @GetMapping("idDupCheck/{userId}")
    @ResponseBody
    public int idDupCheck(@PathVariable String userId) {
        log.info("ID 중복검사 [id] : " + userId);
        return userService.countUser(userId);
    }
}
