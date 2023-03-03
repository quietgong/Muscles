package com.kinaboot.muscles.controller;

import com.kinaboot.muscles.domain.CartDto;
import com.kinaboot.muscles.domain.UserDto;
import com.kinaboot.muscles.service.CartService;
import com.kinaboot.muscles.service.UserService;
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
import java.util.ArrayList;
import java.util.List;

@Controller
public class CartController {
    @Autowired
    CartService cartService;
    @Autowired
    UserService userService;
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
    // 카트 정보를 받아서 주문 정보로 이동
    @PostMapping("/cart/order")
    public String cartToOrder(Integer[] productNo, Integer[] productQty, Model m, HttpSession session) throws Exception {
        String userId = (String) session.getAttribute("id");
        UserDto userDto = userService.read(userId);
        List<CartDto> orderItemList = new ArrayList<>();
        for (int i = 0; i < productNo.length; i++) {
            CartDto cartDto = cartService.getItem(productNo[i]);
            cartDto.setProductNo(productNo[i]);
            cartDto.setProductQty(productQty[i]);
            cartDto.setProductPrice(productQty[i]*cartDto.getProductPrice());
            orderItemList.add(cartDto);
        }
        m.addAttribute("userDto", userDto);
        m.addAttribute("list", orderItemList);
        return "order/page";
    }
}
