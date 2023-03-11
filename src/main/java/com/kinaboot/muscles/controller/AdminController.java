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
    public String adminUser(){
        return "admin/user";
    }
    @GetMapping("/admin/user/manage")
    @ResponseBody
    public ResponseEntity<List<UserDto>> getUser(){
        return new ResponseEntity<>(userService.getAllUser(), HttpStatus.OK);
    }
    @DeleteMapping("/admin/user/manage/{userId}")
    @ResponseBody
    public ResponseEntity<String> removeUser(@PathVariable String userId) throws Exception {
        System.out.println("userid = " + userId);
        // 1. 유저 expiredDate 생성
        userService.removeUser(userId);
        // 2. 회원탈퇴 데이터에 운영자에 의한 탈퇴임을 기록
        userService.createQuit(userId);
        return new ResponseEntity<>("DEL_OK", HttpStatus.OK);
    }

    @GetMapping("/admin/product")
    public String getProduct(Model m){
        List<ProductDto> productDtoList = productService.getAllProduct();
        m.addAttribute("list", productDtoList);
        return "admin/product";
    }
    @GetMapping("/admin/product/manage")
    @ResponseBody
    public ResponseEntity<List<ProductDto>> getProductItems(){
        return new ResponseEntity<>(productService.getAllProduct(), HttpStatus.OK);
    }
    @DeleteMapping("/admin/product/manage/{productNo}")
    @ResponseBody
    public ResponseEntity<String> removeProduct(@PathVariable Integer productNo){
        productService.removeProduct(productNo);
        return new ResponseEntity<>("DEL_OK", HttpStatus.OK);
    }
    @PatchMapping("/admin/product/manage/")
    @ResponseBody
    public ResponseEntity<String> modifyProduct(@RequestBody ProductDto productDto){
        System.out.println("productDto = " + productDto);
        productService.modifyProduct(productDto);
        return new ResponseEntity<>("MOD_OK", HttpStatus.OK);
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
