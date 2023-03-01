package com.kinaboot.muscles.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
@Controller
public class OrderController {
    @GetMapping("/order/list")
    public String orderList(Model m, HttpSession session, HttpServletRequest request) {

        return "order/list";
    }
}
