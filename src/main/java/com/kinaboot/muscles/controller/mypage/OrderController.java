package com.kinaboot.muscles.controller.mypage;

import com.kinaboot.muscles.domain.OrderDto;
import com.kinaboot.muscles.domain.OrderItemDto;
import com.kinaboot.muscles.service.OrderService;
import com.kinaboot.muscles.service.ReviewService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/mypage/order")
public class OrderController {
    private static final Logger logger = LoggerFactory.getLogger(OrderController.class);
    @Autowired
    OrderService orderService;

    @Autowired
    ReviewService reviewService;

    @GetMapping("")
    public String orderList(HttpSession session, Model m) {
        logger.info("유저 주문내역 진입");
        String userId = (String) session.getAttribute("id");
        List<OrderDto> orderDtoList = orderService.findOrders(userId);
        if (orderDtoList != null) {
            orderDtoList = verifyReviewExist(orderService.findOrders(userId));
            m.addAttribute(orderDtoList);
        }
        logger.info("해당 유저 주문내역 : " + orderDtoList);
        return "mypage/myorder";
    }
    private List<OrderDto> verifyReviewExist(List<OrderDto> orderDtoList) {
        for (OrderDto orderDto : orderDtoList) {
            for (OrderItemDto orderItemDto : orderService.findOrderItems(orderDto.getOrderNo()))
                orderItemDto.setHasReview
                        (reviewService.findReview
                                (orderItemDto.getOrderNo(), orderItemDto.getGoodsNo()) != null);
        }
        return orderDtoList;
    }
}
