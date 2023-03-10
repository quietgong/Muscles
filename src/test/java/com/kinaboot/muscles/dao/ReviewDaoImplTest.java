package com.kinaboot.muscles.dao;

import com.kinaboot.muscles.domain.ReviewDto;
import com.kinaboot.muscles.service.ReviewService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.ArrayList;
import java.util.List;

import static org.junit.Assert.*;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
public class ReviewDaoImplTest {
    @Autowired
    ReviewDao reviewDao;

    @Autowired
    ReviewService reviewService;

    @Test
    public void selectReviewListById() {
        String userId = "test7";
        List<ReviewDto> reviewDtoList = reviewDao.selectReviewListById(userId);
        System.out.println("reviewDtoList = " + reviewDtoList);
    }

    @Test
    public void insertReview() {
        reviewService.createReview(new ReviewDto(4,10, "test1", "product3"));
        ReviewDto reviewDto = reviewService.getReviewListByProductNo(4).get(0);
        System.out.println("reviewDto = " + reviewDto);
    }
}