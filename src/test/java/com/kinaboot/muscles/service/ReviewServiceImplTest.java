package com.kinaboot.muscles.service;

import com.kinaboot.muscles.TestConfigure;
import com.kinaboot.muscles.domain.OrderDto;
import com.kinaboot.muscles.domain.OrderItemDto;
import com.kinaboot.muscles.domain.ReviewDto;
import org.junit.Test;
import org.junit.jupiter.api.Order;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

import static org.junit.Assert.*;

public class ReviewServiceImplTest extends TestConfigure {
    @Autowired
    ReviewService reviewService;

    @Autowired
    OrderService orderService;

    @Test
    public void verifyReviewExist(){
        List<OrderDto> orderDtoList = orderService.findOrders("test1");
        for (OrderDto orderDto : orderDtoList) {
            for (OrderItemDto orderItemDto : orderDto.getOrderItemDtoList()){
                ReviewDto reviewDto = reviewService.findReview(orderItemDto.getOrderNo(), orderItemDto.getGoodsNo());
                boolean hasReview = reviewDto != null;
                orderItemDto.setHasReview(hasReview);
            }
        }
        System.out.println("orderDtoList = " + orderDtoList);
    }
}