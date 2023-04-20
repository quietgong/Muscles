package com.kinaboot.muscles.controller.admin;

import com.kinaboot.muscles.handler.SearchCondition;
import com.kinaboot.muscles.service.OrderService;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
@Slf4j
@Controller
@RequestMapping("/admin/order")
public class OrderController {
    @Autowired
    OrderService orderService;
    @GetMapping("")
    public String orderList(SearchCondition sc, Model m) {
        System.out.println("sc = " + sc);
        log.info("주문 목록 조회");
        m.addAttribute("orderDtoList", orderService.findAllOrders(sc));
        return "admin/order";
    }

    @PostMapping("/{orderNo}")
    @ResponseBody
    public ResponseEntity<String> orderAccept(@PathVariable Integer orderNo) {
        log.info("주문번호 : " +orderNo + " 승인");
        orderService.acceptOrder(orderNo);
        return new ResponseEntity<>("ACCEPT_OK", HttpStatus.OK);
    }
}
