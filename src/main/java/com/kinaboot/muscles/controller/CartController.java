package com.kinaboot.muscles.controller;

import com.kinaboot.muscles.domain.CartDto;
import com.kinaboot.muscles.service.CartService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

@Slf4j
@RestController
@RequestMapping("/cart")
public class CartController {
    private final CartService cartService;
    public CartController(CartService cartService) {
        this.cartService = cartService;
    }

    @GetMapping("/{userId}")
    public ResponseEntity<List<CartDto>> cartList(@PathVariable String userId) {
        log.info("장바구니 페이지 진입");
        return new ResponseEntity<>(cartService.findCartItems(userId), HttpStatus.OK);
    }

    @GetMapping("/count/{userId}")
    public ResponseEntity<Integer> cartCount(@PathVariable String userId) {
        log.info("사용자 : " + userId + " 장바구니 아이템 카운트");
        return new ResponseEntity<>(cartService.countCart(userId), HttpStatus.OK);
    }

    @PostMapping("/")
    public ResponseEntity<String> cartAdd(@RequestBody CartDto cartDto) {
        log.info("장바구니 추가");
        return new ResponseEntity<>(cartService.addCartItem(cartDto), HttpStatus.OK);
    }

    @DeleteMapping("/{goodsNo}")
    public ResponseEntity<String> cartRemove(@PathVariable Integer goodsNo, HttpSession session) {
        log.info("장바구니 삭제 상품 번호 : " + goodsNo);
        cartService.removeCartItem((String) session.getAttribute("id"), goodsNo);
        return new ResponseEntity<>("DEL_OK", HttpStatus.OK);
    }
}
