package com.kinaboot.muscles.controller;

import com.kinaboot.muscles.domain.CartDto;
import com.kinaboot.muscles.domain.OrderDto;
import com.kinaboot.muscles.domain.ProductDto;
import com.kinaboot.muscles.domain.UserDto;
import com.kinaboot.muscles.service.OrderService;
import com.kinaboot.muscles.service.ProductService;
import com.kinaboot.muscles.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class AdminController {
    @Autowired
    UserService userService;

    @Autowired
    ProductService productService;

    @Autowired
    OrderService orderService;

    @GetMapping("/admin/user")
    public String getUser(Model m){
        List<UserDto> userDtoList = userService.getAllUser();
        m.addAttribute("list", userDtoList);
        return "admin/user";
    }
    @GetMapping("/admin/product")
    public String getProduct(Model m){
        List<ProductDto> productDtoList = productService.getAllProduct();
        m.addAttribute("list", productDtoList);
        return "admin/product";
    }
    @GetMapping("/admin/order")
    public String getOrder(Model m){
        List<OrderDto> orderDtoList = orderService.getAdminOrderList();
        m.addAttribute(orderDtoList);
        return "admin/order";
    }
    @PostMapping("/admin/order/accept/{orderNo}")
    @ResponseBody
    public ResponseEntity<String> acceptOrder(@PathVariable Integer orderNo) {
        orderService.acceptOrder(orderNo);
        return new ResponseEntity<>("ACCEPT_OK", HttpStatus.OK);
    }
}
