package com.kinaboot.muscles.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kinaboot.muscles.domain.*;
import com.kinaboot.muscles.service.OrderService;
import com.kinaboot.muscles.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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

    @GetMapping("/order/detail")
    public String getOrderDetail(String userId, Integer orderNo) {
        return "order/detail";
    }

    @GetMapping("/order/{orderNo}")
    @ResponseBody
    public ResponseEntity<List<OrderItemDto>> getOrder(@PathVariable Integer orderNo) {
        List<OrderItemDto> orderItemDtoList = orderService.getOrderItemList(orderNo);
        return new ResponseEntity<>(orderItemDtoList, HttpStatus.OK);
    }

    @GetMapping("/order/list")
    public String getOrderList(HttpSession session, Model m) {
        String userId = (String) session.getAttribute("id");
        List<OrderDto> orderDtoList = orderService.getOrderList(userId);
        m.addAttribute(orderDtoList);
        return "order/list";
    }

    @PostMapping("/order/complete")
    public String orderList(String orderJsonData, DeliveryDto deliveryDto, PaymentDto paymentDto, HttpSession session, Model m) throws Exception {
        String userId = (String) session.getAttribute("id");
        List<OrderItemDto> orderItemDtoList = JsonToJava(orderJsonData);
        OrderDto orderDto = new OrderDto(orderItemDtoList, deliveryDto, paymentDto, userId, "대기중");

        orderService.createOrder(userId, orderDto);
        UserDto userDto = userService.read(userId);

        m.addAttribute(userDto);
        m.addAttribute(orderItemDtoList);
        return "order/complete";
    }

    public List<OrderItemDto> JsonToJava(String rowData) throws JsonProcessingException {
        ObjectMapper objectMapper = new ObjectMapper();
        return objectMapper.readValue(rowData, new TypeReference<List<OrderItemDto>>() {
        });
    }
}
