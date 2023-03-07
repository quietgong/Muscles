package com.kinaboot.muscles.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kinaboot.muscles.domain.*;
import com.kinaboot.muscles.service.OrderService;
import com.kinaboot.muscles.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Controller
public class OrderController {
    @Autowired
    OrderService orderService;
    @Autowired
    UserService userService;

    @GetMapping("/order/list")
    public String getOrderList(){
        return "order/list";
    }
    @PostMapping("/order/complete")
    public String orderList(String orderJsonData, DeliveryDto deliveryDto, PaymentDto paymentDto, HttpSession session, Model m) throws Exception {
        String userId = (String) session.getAttribute("id");
        List<OrderDto> orderDtoList = JsonToJava(orderJsonData);

        orderService.saveOrder(userId, orderDtoList, deliveryDto, paymentDto);

        UserDto userDto = userService.read(userId);
        m.addAttribute(userDto);
        m.addAttribute(orderDtoList);
        m.addAttribute(deliveryDto);
        m.addAttribute(paymentDto);
        return "order/complete";
    }
    public List<OrderDto> JsonToJava(String rowData) throws JsonProcessingException {
        ObjectMapper objectMapper = new ObjectMapper();
        return objectMapper.readValue(rowData, new TypeReference<List<OrderDto>>() {});
    }
}
