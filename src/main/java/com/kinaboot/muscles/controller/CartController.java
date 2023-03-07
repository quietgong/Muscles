package com.kinaboot.muscles.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kinaboot.muscles.domain.CartDto;
import com.kinaboot.muscles.domain.OrderItemDto;
import com.kinaboot.muscles.domain.UserDto;
import com.kinaboot.muscles.service.CartService;
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
@RequestMapping("/cart")
public class CartController {
    @Autowired
    CartService cartService;
    @Autowired
    UserService userService;
    @GetMapping("")
    public String view(){
        return "/cart";
    }
    @GetMapping("/get")
    @ResponseBody
    public ResponseEntity<List<CartDto>> cart(HttpSession session){
        String userId = (String) session.getAttribute("id");
        List<CartDto> cartItemList = cartService.getCartItems(userId);
        return new ResponseEntity<>(cartItemList, HttpStatus.OK);
    }
    @PostMapping("/add")
    @ResponseBody
    public ResponseEntity<String> addCart(@RequestBody CartDto cartDto, HttpSession session){
        String userId = (String) session.getAttribute("id");
        System.out.println("cartDto = " + cartDto);

        // 추가하고자 하는 아이템이 이미 장바구니에 있을 때
        int rowCnt = cartService.checkCartProduct(userId, String.valueOf(cartDto.getProductNo()));
        if(rowCnt!=0)
            return new ResponseEntity<>("ADD_FAIL", HttpStatus.OK);
        cartService.addCartItem(userId,cartDto);
        return new ResponseEntity<>("ADD_OK", HttpStatus.OK);
    }

    @PostMapping("/remove")
    public String cartRemove
            (@RequestParam(value="deleteItemList[]") List<String> deleteList, HttpSession session){
        String userId = (String) session.getAttribute("id");
        cartService.removeCartItem(userId, deleteList);
        return "cart";
    }
    // 카트 정보를 받아서 주문 정보로 이동
    @PostMapping("/order")
    public String cartToOrder(String jsonData, Model m, HttpSession session) throws Exception {
        String userId = (String) session.getAttribute("id");
        UserDto userDto = userService.read(userId);
        List<OrderItemDto> orderItemDtoList = JsonToJava(jsonData);
        m.addAttribute("userDto", userDto);
        m.addAttribute("list", orderItemDtoList);
        return "order/page";
    }
    public List<OrderItemDto> JsonToJava(String jsonData) throws JsonProcessingException {
        ObjectMapper objectMapper = new ObjectMapper();
        return objectMapper.readValue(jsonData, new TypeReference<List<OrderItemDto>>() {
        });
    }
}
