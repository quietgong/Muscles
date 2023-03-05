package com.kinaboot.muscles.controller;

import com.kinaboot.muscles.domain.*;
import com.kinaboot.muscles.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Controller
public class OrderController {
    @Autowired
    UserService userService;

    @PostMapping("/order/complete")
    public String orderList
            (CartDto cartDto, DeliveryDto deliveryDto, PaymentDto paymentDto, HttpSession session, Model m) throws Exception {

        String userId = (String) session.getAttribute("id");
        OrderDto orderDto = new OrderDto();
        orderDto.setDeliveryDto(deliveryDto);

        // order, delivery, payment DB에 데이터 저장

        // 재고 수량변경

        // 구매 제품 카트에서 삭제
        List<CartDto> orderedProductList = new ArrayList<>();
        UserDto userDto = userService.read(userId);
        m.addAttribute(userDto);
        m.addAttribute("productList", orderedProductList);
        m.addAttribute(deliveryDto);
        m.addAttribute(paymentDto);

        return "order/complete";
    }

}
