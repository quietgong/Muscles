package com.kinaboot.muscles.controller;

import com.kinaboot.muscles.domain.CartDto;
import com.kinaboot.muscles.domain.ProductDto;
import com.kinaboot.muscles.service.CartService;
import com.kinaboot.muscles.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class CartController {
    @Autowired
    CartService cartService;
    @GetMapping("/cart")
    public String view(){
        return "/cart";
    }
    @GetMapping("/cart/get")
    @ResponseBody
    public ResponseEntity<List<CartDto>> cart(HttpSession session){
        String userId = (String) session.getAttribute("id");
        List<CartDto> cartItemList = cartService.getCartItems(userId);
        return new ResponseEntity<>(cartItemList, HttpStatus.OK);
    }
    @PostMapping("/cart/add")
    @ResponseBody
    public ResponseEntity<String> addCart(String productNo, String productQty, HttpSession session){
        String userId = (String) session.getAttribute("id");
        // 추가하고자 하는 아이템이 이미 장바구니에 있을 때
        int rowCnt = cartService.checkCartProduct(userId, productNo);
        if(rowCnt!=0){
            return new ResponseEntity<>("ADD_FAIL", HttpStatus.OK);
        }
        cartService.addCartItem(userId, productNo, productQty);
        return new ResponseEntity<>("ADD_OK", HttpStatus.OK);
    }

    @PostMapping("/cart/remove")
    public String cartRemove
            (@RequestParam(value="deleteItemList[]") List<String> deleteList, HttpSession session){
        String userId = (String) session.getAttribute("id");
        cartService.removeCartItem(userId, deleteList);
        return "cart";
    }
}
