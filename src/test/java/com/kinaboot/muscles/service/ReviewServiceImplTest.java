package com.kinaboot.muscles.service;

import com.kinaboot.muscles.TestConfigure;
import com.kinaboot.muscles.dao.ReviewDao;
import com.kinaboot.muscles.domain.OrderDto;
import com.kinaboot.muscles.domain.OrderItemDto;
import com.kinaboot.muscles.domain.ReviewDto;
import com.kinaboot.muscles.domain.ReviewImgDto;
import org.junit.Test;
import org.junit.jupiter.api.Order;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

import static org.junit.Assert.*;

public class ReviewServiceImplTest extends TestConfigure {
    @Autowired
    ReviewService reviewService;
    @Autowired
    ReviewDao reviewDao;

    @Autowired
    OrderService orderService;

    @Test
    public void findReviews(){
        List<ReviewDto> reviewDtoList = reviewDao.selectReviewListById("test1");
        for(ReviewDto reviewDto: reviewDtoList){
            reviewDto.setReviewImgDtoList(reviewDao.selectReviewImg(reviewDto.getReviewNo()));
        }
        System.out.println("reviewDtoList = " + reviewDtoList);
    }
    @Test
    public void insertReview() {
        ReviewDto reviewDto = new ReviewDto();
        List<ReviewImgDto> reviewImgDtoList = reviewDto.getReviewImgDtoList();
        if (reviewImgDtoList != null) {
            for (ReviewImgDto reviewImgDto : reviewImgDtoList) {
                reviewImgDto.setReviewNo(reviewDao.selectNewReviewNo());
                reviewDao.insertReviewImg(reviewImgDto);
            }
        }
        reviewDao.insertReview(reviewDto);
    }

    @Test
    public void findNewReviewNo() {
        reviewDao.selectNewReviewNo();
    }

    @Test
    public void verifyReviewExist() {
//        List<OrderDto> orderDtoList = orderService.findOrders("test1");
//        for (OrderDto orderDto : orderDtoList) {
//            for (OrderItemDto orderItemDto : orderDto.getOrderItemDtoList()){
//                ReviewDto reviewDto = reviewService.findReview(orderItemDto.getOrderNo(), orderItemDto.getGoodsNo());
//                boolean hasReview = reviewDto != null;
//                orderItemDto.setHasReview(hasReview);
//            }
//        }
//        System.out.println("orderDtoList = " + orderDtoList);
    }

}