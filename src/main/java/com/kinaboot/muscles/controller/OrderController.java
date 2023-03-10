package com.kinaboot.muscles.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kinaboot.muscles.domain.*;
import com.kinaboot.muscles.service.OrderService;
import com.kinaboot.muscles.service.ReviewService;
import com.kinaboot.muscles.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

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
    @Autowired
    ReviewService reviewService;

    @GetMapping("/order/detail")
    public String getOrderDetail(Integer orderNo, Model m) {
        System.out.println(orderNo);
        OrderDto orderDto = orderService.getOrderDetail(orderNo);
        m.addAttribute(orderDto);
        return "order/detail";
    }

    @GetMapping("/order")
    @ResponseBody
    public ResponseEntity<OrderItemDto> getOrder(Integer orderNo, Integer productNo) {
        OrderItemDto orderItemDto = orderService.getOrderItem(orderNo, productNo);
        return new ResponseEntity<>(orderItemDto, HttpStatus.OK);
    }
    // 주문취소
    @DeleteMapping("/order/{orderNo}")
    public ResponseEntity<String> removeOrder(@PathVariable Integer orderNo){
        orderService.removeOrder(orderNo);
        return new ResponseEntity<>("DEL_OK", HttpStatus.OK);
    }

    @GetMapping("/order/list")
    public String getOrderList(HttpSession session, Model m) {
        String userId = (String) session.getAttribute("id");
        List<OrderDto> orderDtoList = verifyReviewExist(orderService.getOrderList(userId));
        m.addAttribute(orderDtoList);
        return "order/list";
    }

    private List<OrderDto> verifyReviewExist(List<OrderDto> orderDtoList) {
        for (OrderDto orderDto : orderDtoList) {
            List<OrderItemDto> orderItemDtoList = orderDto.getOrderItemDtoList();
            for (OrderItemDto orderItemDto : orderItemDtoList)
                orderItemDto.setHasReview
                        (reviewService.getReviewOne
                                (orderItemDto.getOrderNo(), orderItemDto.getProductNo()) != null);
        }
        return orderDtoList;
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
