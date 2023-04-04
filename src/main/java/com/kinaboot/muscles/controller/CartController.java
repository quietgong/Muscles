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
    @Autowired
    UserService userService;

    @GetMapping("/")
    public ResponseEntity<List<CartDto>> cart(HttpSession session) {
        logger.info("장바구니 페이지 진입");
        String userId = (String) session.getAttribute("id");
        return new ResponseEntity<>(cartService.getCartItems(userId), HttpStatus.OK);
    }

    @PostMapping("/")
    public ResponseEntity<String> addCart(@RequestBody CartDto cartDto, HttpSession session) {
        String userId = (String) session.getAttribute("id");
        // 추가하고자 하는 아이템이 이미 장바구니에 있을 때
        if(cartService.checkCartProduct(userId, cartDto.getProductNo())!=0)
            return new ResponseEntity<>("ADD_FAIL", HttpStatus.OK);
        cartService.addCartItem(userId, cartDto);
        return new ResponseEntity<>("ADD_OK", HttpStatus.OK);
    }

    @DeleteMapping("/{productNo}")
    public ResponseEntity<String> cartRemove(@PathVariable Integer productNo, HttpSession session) {
        logger.info("장바구니 상품 삭제");
        logger.info("삭제된 상품 번호 : " + productNo);

        cartService.removeCartItem((String) session.getAttribute("id"), productNo);
        return new ResponseEntity<>("DEL_OK", HttpStatus.OK);
    }

}
