package com.kinaboot.muscles.controller;

import com.kinaboot.muscles.domain.CouponDto;
import com.kinaboot.muscles.domain.PointDto;
import com.kinaboot.muscles.handler.SearchCondition;
import com.kinaboot.muscles.service.OrderService;
import com.kinaboot.muscles.service.ReviewService;
import com.kinaboot.muscles.service.UserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

@Slf4j
@Controller
@RequestMapping("/mypage")
public class MypageController {
    private final UserService userService;
    private final OrderService orderService;

    public MypageController(UserService userService, OrderService orderService) {
        this.userService = userService;
        this.orderService = orderService;
    }
    
    @GetMapping("/coupon/{userId}")
    public ResponseEntity<List<CouponDto>> findCoupon(@PathVariable String userId) {
        log.info("쿠폰 목록 조회");
        return new ResponseEntity<>(userService.findCoupons(userId), HttpStatus.OK);
    }

    @PostMapping("/coupon/{userId}/{recommendId}")
    public ResponseEntity<String> addCoupon(@PathVariable String userId, @PathVariable String recommendId) {
        log.info("쿠폰 등록");
        String msg = userService.addCoupon(userId, recommendId) != 0 ? "ADD_OK" : "ADD_FAIL";
        return new ResponseEntity<>(msg, HttpStatus.OK);
    }

    @GetMapping("/point/{userId}")
    @ResponseBody
    public ResponseEntity<List<PointDto>> pointList(@PathVariable String userId) {
        log.info("포인트 내역 조회");
        return new ResponseEntity<>(userService.findPoints(userId), HttpStatus.OK);
    }

    @GetMapping("/order")
    public String orderList(HttpSession session, Model m, SearchCondition sc) {
        log.info("유저 주문내역 진입");
        String userId = (String) session.getAttribute("id");
        sc.setUserId(userId);
        m.addAttribute("orderDtoList", orderService.findOrders(sc));
        return "mypage/myorder";
    }
}
