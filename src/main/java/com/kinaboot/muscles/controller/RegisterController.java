package com.kinaboot.muscles.controller;

import com.kinaboot.muscles.dao.UserDao;
import com.kinaboot.muscles.domain.UserDto;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
public class RegisterController {
    private final UserDao userDao;
    RegisterController(UserDao userDao){
        this.userDao=userDao;
    }
    @GetMapping("/register")
    public String register(){
        return "register";
    }
    @PostMapping("/register")
    public String registerUser(UserDto userDto, HttpServletRequest request) throws Exception {
        userDto.setAddress(String.join(" ", request.getParameterValues("address")));
        System.out.println("userDto = " + userDto);
        // 1. 중복된 아이디가 있으면 오류 메세지 출력
//        String id = userDto.getId();
//        int rowCnt = userDao.searchIdCnt(id);
//        if(rowCnt!=0){
//            String msg = "중복된 아이디입니다.";
//            return "redirect:/register?msg=" + URLEncoder.encode(msg, "UTF-8");
//        }
//        userDao.insertUser(userDto);
        return "redirect:/";
    }
}
