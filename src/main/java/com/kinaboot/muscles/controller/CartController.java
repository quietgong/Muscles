package com.kinaboot.muscles.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kinaboot.muscles.domain.CartDto;
import com.kinaboot.muscles.domain.OrderItemDto;
import com.kinaboot.muscles.service.CartService;
import com.kinaboot.muscles.service.UserService;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

@Slf4j
@RestController
@RequestMapping("/cart")
public class CartController {
    @Autowired
    CartService cartService;

    @GetMapping("/{userId}")
    public ResponseEntity<List<CartDto>> cartList(@PathVariable String userId) {
        log.info("장바구니 페이지 진입");
        return new ResponseEntity<>(cartService.findCartItems(userId), HttpStatus.OK);
    }

    @GetMapping("/{userId}/")
    public ResponseEntity<Integer> cartCount(@PathVariable String userId) {
        log.info("사용자 : " + userId + " 장바구니 아이템 카운트");
        return new ResponseEntity<>(cartService.countCart(userId), HttpStatus.OK);
    }

    @PostMapping("/")
    public ResponseEntity<String> cartAdd(@RequestBody CartDto cartDto, HttpSession session) {
        log.info("장바구니 추가");
        String userId = (String) session.getAttribute("id");
        return new ResponseEntity<>(cartService.addCartItem(userId, cartDto), HttpStatus.OK);
    }

    @DeleteMapping("/{goodsNo}")
    public ResponseEntity<String> cartRemove(@PathVariable Integer goodsNo, HttpSession session) {
        log.info("장바구니 삭제 상품 번호 : " + goodsNo);
        cartService.removeCartItem((String) session.getAttribute("id"), goodsNo);
        return new ResponseEntity<>("DEL_OK", HttpStatus.OK);
    }
}
