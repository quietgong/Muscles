package com.kinaboot.muscles.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kinaboot.muscles.domain.CartDto;
import com.kinaboot.muscles.domain.OrderItemDto;
import com.kinaboot.muscles.service.CartService;
import com.kinaboot.muscles.service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

@RestController
@RequestMapping("/cart")
public class CartController {
    private static final Logger logger = LoggerFactory.getLogger(CartController.class);
    @Autowired
    CartService cartService;

    @GetMapping("/")
    public ResponseEntity<List<CartDto>> cartList(HttpSession session) {
        logger.info("장바구니 페이지 진입");
        String userId = (String) session.getAttribute("id");
        return new ResponseEntity<>(cartService.findCartItems(userId), HttpStatus.OK);
    }

    @GetMapping("/{userId}")
    public ResponseEntity<Integer> cartCount(@PathVariable String userId){
        return new ResponseEntity<>(cartService.countCart(userId), HttpStatus.OK);
    }
    @PostMapping("/")
    public ResponseEntity<String> cartAdd(@RequestBody CartDto cartDto, HttpSession session) {
        logger.info("장바구니 추가");
        String userId = (String) session.getAttribute("id");
        return new ResponseEntity<>(cartService.addCartItem(userId, cartDto), HttpStatus.OK);
    }
    @DeleteMapping("/{goodsNo}")
    public ResponseEntity<String> cartRemove(@PathVariable Integer goodsNo, HttpSession session) {
        logger.info("장바구니 상품 삭제");
        logger.info("삭제된 상품 번호 : " + goodsNo);

        cartService.removeCartItem((String) session.getAttribute("id"), goodsNo);
        return new ResponseEntity<>("DEL_OK", HttpStatus.OK);
    }
}
