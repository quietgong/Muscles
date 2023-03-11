package com.kinaboot.muscles.controller;

import com.kinaboot.muscles.dao.UserDao;
import com.kinaboot.muscles.domain.UserDto;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.net.URLEncoder;

@Controller
@RequestMapping("/register")
public class RegisterController {
    private final UserDao userDao;

    RegisterController(UserDao userDao) {
        this.userDao = userDao;
    }

    @GetMapping("")
    public String register() {
        return "register";
    }

    @PostMapping("")
    public String registerUser(UserDto userDto, HttpServletRequest request) throws Exception {
        userDto.setAddress(String.join(" ", request.getParameterValues("address")));
        System.out.println("userDto = " + userDto);
        // 중복된 아이디가 있으면 오류 메세지 출력
        String id = userDto.getUserId();
        if (userDao.selectUser(id) != null) {
            String msg = "중복된 아이디입니다.";
            return "redirect:/?msg=" + URLEncoder.encode(msg, "UTF-8");
        }
        userDao.insertUser(userDto);
        return "redirect:/";
    }

    @GetMapping("/idDupCheck")
    @ResponseBody
    public int idDupCheck(@RequestParam(value = "inputId") String inputId){
        if (userDao.selectUser(inputId) == null)
            return 0;
        else return 1;
    }
}
