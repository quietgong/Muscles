package com.kinaboot.muscles.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kinaboot.muscles.domain.DeliveryDto;
import com.kinaboot.muscles.domain.OrderDto;
import com.kinaboot.muscles.domain.OrderItemDto;
import com.kinaboot.muscles.domain.PaymentDto;
import com.kinaboot.muscles.service.OrderService;
import com.kinaboot.muscles.service.ReviewService;
import com.kinaboot.muscles.service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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
@RequestMapping("/order")
public class OrderController {
    private static final Logger logger = LoggerFactory.getLogger(OrderController.class);
    @Autowired
    OrderService orderService;
    @Autowired
    UserService userService;
    @Autowired
    ReviewService reviewService;

    @GetMapping("/{orderNo}")
    public String orderDetails(@PathVariable Integer orderNo, Model m) {
        logger.info("상세 주문내역 진입");
        m.addAttribute("orderDto", orderService.findOrder(orderNo));
        return "order/detail";
    }

    @GetMapping("")
    @ResponseBody
    public ResponseEntity<OrderItemDto> orderItemList(Integer orderNo, Integer productNo) {
        logger.info("주문상품 목록 가져오기");
        return new ResponseEntity<>(orderService.findOrderItem(orderNo, productNo),
                HttpStatus.OK);
    }

    @PostMapping("/checkout")
    public String orderSave(String orderData, Model m, HttpSession session) throws Exception {
        logger.info("결제 전 주문 페이지 진입");
        String userId = (String) session.getAttribute("id");
        if (userService.findCoupons(userId) != null)
            m.addAttribute("couponDtoList", userService.findCoupons(userId));
        m.addAttribute("userDto", userService.findUser(userId));
        m.addAttribute("orderList", orderData);
        return "order/checkout";
    }

    @PostMapping("/")
    public String orderAdd(String orderData, HttpServletRequest request, HttpSession session, Model m) throws Exception {
        logger.info("결제 후 주문 처리");
        String userId = (String) session.getAttribute("id");
        int orderNo = orderService.addOrder(userId, orderData, request);

        m.addAttribute("orderDto", orderService.findOrder(orderNo));
        m.addAttribute("userDto", userService.findUser(userId));
        return "order/complete";
    }

    @DeleteMapping("{orderNo}")
    public ResponseEntity<String> removeOrder(HttpSession session, @PathVariable Integer orderNo) {
        logger.info("[주문번호] : " + orderNo + " 주문취소");
        String userId = (String) session.getAttribute("id");
        orderService.removeOrder(userId, orderNo);
        return new ResponseEntity<>("DEL_OK", HttpStatus.OK);
    }
}
