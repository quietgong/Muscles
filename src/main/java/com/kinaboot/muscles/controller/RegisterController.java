package com.kinaboot.muscles.controller;

import com.kinaboot.muscles.dao.UserDao;
import com.kinaboot.muscles.domain.UserDto;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.net.URLEncoder;

@Controller
@RequestMapping("/register")
public class RegisterController {
    private static final Logger logger = LoggerFactory.getLogger(RegisterController.class);

    private final UserDao userDao;

    RegisterController(UserDao userDao) {
        this.userDao = userDao;
    }

    @GetMapping("")
    public String register() {
        return "register";
    }

    @PostMapping("")
    public String registerUser(UserDto userDto) throws Exception {
        logger.info("회원가입 진입");
        String id = userDto.getUserId();
        if (userDao.selectUser(id) != null)
            return "redirect:/?msg=" + URLEncoder.encode("중복된 아이디입니다.", "UTF-8");
        userDao.insertUser(userDto);

        logger.info("ID : " + userDto.getUserId() + "생성 성공");
        return "redirect:/";
    }

    @GetMapping("/idDupCheck/{id}")
    @ResponseBody
    public int idDupCheck(@PathVariable String id) {
        logger.info("중복검사 ID : " + id);

        return userDao.selectUser(id) == null ? 0 : 1;
    }
}
