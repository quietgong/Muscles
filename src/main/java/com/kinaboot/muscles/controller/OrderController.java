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

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/order/")
public class OrderController {
    private static final Logger logger = LoggerFactory.getLogger(OrderController.class);

    @Autowired
    OrderService orderService;
    @Autowired
    UserService userService;
    @Autowired
    ReviewService reviewService;

    @GetMapping("{orderNo}")
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

    // 바로구매 또는 장바구니 주문
    // 선택된 상품들의 정보를 주문 정보 페이지로 전달
    @PostMapping("")
    public String orderSave(String jsonData, Model m, HttpSession session) throws Exception {
        logger.info("주문 페이지 진입");
        String userId = (String) session.getAttribute("id");
        if (userService.findCoupons(userId) != null)
            m.addAttribute("couponDtoList", userService.findCoupons(userId));
        m.addAttribute("userDto", userService.findUser(userId));
        m.addAttribute("list", JsonToJava(jsonData));
        return "order/checkout";
    }

    // 주문취소
    @DeleteMapping("{orderNo}")
    public ResponseEntity<String> removeOrder(HttpSession session, @PathVariable Integer orderNo) {
        String userId = (String) session.getAttribute("id");
        orderService.removeOrder(userId, orderNo);
        return new ResponseEntity<>("DEL_OK", HttpStatus.OK);
    }

    // 결제하기 버튼
    @PostMapping("/complete")
    public String orderAdd(String orderJsonData, DeliveryDto deliveryDto, PaymentDto paymentDto,
                            String couponName, Integer point, HttpSession session, Model m) throws Exception {
        String userId = (String) session.getAttribute("id");
        OrderDto orderDto = new OrderDto
                (JsonToJava(orderJsonData), deliveryDto, paymentDto, userId, "대기중");
        orderDto.setOrderNo(orderService.findOrderNo());
        // 주문정보 생성
        orderService.addOrder(userId, orderDto);
        // 쿠폰 상태 변경
        userService.modifyCoupon(userId, couponName, String.valueOf(orderDto.getOrderNo()));
        // 포인트 사용 적용
        if (point != 0)
            userService.modifyPoint(userId, point, String.valueOf(orderDto.getOrderNo()));

        m.addAttribute(orderDto);
        m.addAttribute("userDto", userService.findUser(userId));
        return "order/complete";
    }

    public List<OrderItemDto> JsonToJava(String rowData) throws JsonProcessingException {
        ObjectMapper objectMapper = new ObjectMapper();
        return objectMapper.readValue(rowData, new TypeReference<List<OrderItemDto>>() {
        });
    }
}
