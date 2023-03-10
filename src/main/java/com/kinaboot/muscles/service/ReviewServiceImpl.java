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
    public ReviewDto getReviewOne(int orderNo, int productNo) {
        return reviewDao.selectReview(orderNo, productNo);
    }

    @Override
    public int modifyReview(ReviewDto reviewDto) {
        return reviewDao.updateReview(reviewDto);
    }

    @Override
    public int removeReview(Integer orderNo, Integer productNo, String userId) {
        return reviewDao.deleteReview(orderNo, productNo, userId);
    }

    @Override
    public int createReview(ReviewDto reviewDto) {
        return reviewDao.insertReview(reviewDto);
    }

    @Override
    public List<ReviewDto> getReviewListByProductNo(Integer productNo) {
        return reviewDao.selectReviewListByProductId(productNo);
    }

    @Override
    public List<ReviewDto> getReviewListById(String userId) {
        return reviewDao.selectReviewListById(userId);
    }
}
