package com.kinaboot.muscles.controller.mypage;

import com.kinaboot.muscles.domain.CouponDto;
import com.kinaboot.muscles.service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/mypage/coupon/")
public class CouponController {
    private static final Logger logger = LoggerFactory.getLogger(CouponController.class);
    @Autowired
    UserService userService;

    @GetMapping("{userId}")
    public ResponseEntity<List<CouponDto>> findCoupon(@PathVariable String userId) {
        logger.info("쿠폰 목록 조회");
        return new ResponseEntity<>(userService.findCoupons(userId), HttpStatus.OK);
    }

    @PostMapping("{userId}/{recommendId}")
    public ResponseEntity<String> addCoupon(@PathVariable String userId, @PathVariable String recommendId) {
        logger.info("쿠폰 등록");
        String msg = userService.addCoupon(userId, recommendId) != 0 ? "ADD_OK" : "ADD_FAIL";
        return new ResponseEntity<>(msg, HttpStatus.OK);
    }
}
