package com.kinaboot.muscles.controller.mypage;

import com.kinaboot.muscles.domain.OrderDto;
import com.kinaboot.muscles.domain.OrderItemDto;
import com.kinaboot.muscles.domain.ReviewDto;
import com.kinaboot.muscles.handler.SearchCondition;
import com.kinaboot.muscles.service.OrderService;
import com.kinaboot.muscles.service.ReviewService;
import lombok.extern.slf4j.Slf4j;
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
@Slf4j
@Controller
@RequestMapping("/mypage/order")
public class OrderController {
    @Autowired
    OrderService orderService;

    @Autowired
    ReviewService reviewService;

    @GetMapping("")
    public String orderList(HttpSession session, Model m, SearchCondition sc) {
        log.info("유저 주문내역 진입");
        String userId = (String) session.getAttribute("id");
        List<OrderDto> orderDtoList = orderService.findOrders(userId, sc);
        if (orderDtoList != null)
            m.addAttribute("orderDtoList", verifyReviewExist(orderDtoList));
        return "mypage/myorder";
    }

    private List<OrderDto> verifyReviewExist(List<OrderDto> orderDtoList) {
        for (OrderDto orderDto : orderDtoList) {
            for (OrderItemDto orderItemDto : orderDto.getOrderItemDtoList()){
                ReviewDto reviewDto = reviewService.findReview(orderItemDto.getOrderNo(), orderItemDto.getGoodsNo());
                boolean hasReview = reviewDto != null;
                orderItemDto.setHasReview(hasReview);
            }
        }
        return orderDtoList;
    }
}
