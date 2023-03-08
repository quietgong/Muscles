package com.kinaboot.muscles.service;

import com.kinaboot.muscles.dao.ReviewDao;
import com.kinaboot.muscles.domain.ReviewDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ReviewServiceImpl implements ReviewService{
    @Autowired
    ReviewDao reviewDao;

    @Override
    public int createReview(List<ReviewDto> reviewDtoList) {
        return reviewDao.insertReview(reviewDtoList);
    }

    @Override
    public List<ReviewDto> getReviewListById(String userId) {
        return reviewDao.selectReviewListById(userId);
    }
}
