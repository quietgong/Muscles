package com.kinaboot.muscles.dao;

import com.kinaboot.muscles.domain.ReviewDto;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

import static org.junit.Assert.*;
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
public class ReviewDaoImplTest {
@Autowired
ReviewDao reviewDao;
    @Test
    public void selectReviewListById() {
        String userId = "test10";
        List<ReviewDto> reviewDtoList = reviewDao.selectReviewListById(userId);
        System.out.println("reviewDtoList = " + reviewDtoList);
    }
}