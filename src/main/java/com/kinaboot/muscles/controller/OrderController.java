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
@RequestMapping("/order")
public class OrderController {
    @Autowired
    OrderService orderService;
    @Autowired
    UserService userService;
    @Autowired
    ReviewService reviewService;

    @GetMapping("/detail")
    public String getOrderDetail(Integer orderNo, Model m) {
        m.addAttribute("orderDto", orderService.getOrderDetail(orderNo));
        return "order/detail";
    }

    @GetMapping("")
    @ResponseBody
    public ResponseEntity<OrderItemDto> getOrder(Integer orderNo, Integer productNo) {
        return new ResponseEntity<>(orderService.getOrderItem(orderNo, productNo),
                HttpStatus.OK);
    }
    // 바로구매 또는 장바구니 주문
    // 선택된 상품들의 정보를 주문 정보 페이지로 전달
    @PostMapping("")
    public String showOrderPage(String jsonData, Model m, HttpSession session) throws Exception {
        String userId = (String) session.getAttribute("id");
        m.addAttribute("couponDtoList", userService.getCoupon(userId));
        m.addAttribute("userDto", userService.read(userId));
        m.addAttribute("list", JsonToJava(jsonData));
        return "order/page";
    }

    // 주문취소
    @DeleteMapping("/{orderNo}")
    public ResponseEntity<String> removeOrder(@PathVariable Integer orderNo){
        orderService.removeOrder(orderNo);
        return new ResponseEntity<>("DEL_OK", HttpStatus.OK);
    }

    @GetMapping("/list")
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

    // 결제하기 버튼
    @PostMapping("/complete")
    public String orderList(String orderJsonData, DeliveryDto deliveryDto, PaymentDto paymentDto,
                            String couponName, Integer point, HttpSession session, Model m) throws Exception {
        String userId = (String) session.getAttribute("id");
        OrderDto orderDto = new OrderDto
                (JsonToJava(orderJsonData), deliveryDto, paymentDto, userId, "대기중");
        orderDto.setOrderNo(orderService.getUserRecentOrderNo());
        // 주문정보 생성
        orderService.createOrder(userId, orderDto);
        // 쿠폰 상태 변경
        userService.modifyUserCouponStatus(userId, couponName);
        // 포인트 사용 적용
        if(point!=0)
            userService.modifyUserPoint(userId, point, orderDto.getOrderNo());

        m.addAttribute(orderDto);
        m.addAttribute("userDto", userService.read(userId));
        return "order/complete";
    }

    public List<OrderItemDto> JsonToJava(String rowData) throws JsonProcessingException {
        ObjectMapper objectMapper = new ObjectMapper();
        return objectMapper.readValue(rowData, new TypeReference<List<OrderItemDto>>() {
        });
    }
}
