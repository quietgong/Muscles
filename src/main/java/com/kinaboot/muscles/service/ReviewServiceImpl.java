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
    public ReviewDto findReview(int orderNo, int goodsNo) {
        return reviewDao.selectReview(orderNo, goodsNo);
    }

    @Override
    public int modifyReview(ReviewDto reviewDto) {
        return reviewDao.updateReview(reviewDto);
    }

    @Override
    public int removeReview(Integer reviewNo) {
        return reviewDao.deleteReview(reviewNo);
    }

    @Override
    public int addReview(ReviewDto reviewDto) {
        return reviewDao.insertReview(reviewDto);
    }

    @Override
    public List<ReviewDto> findReviews(Integer goodsNo) {
        return reviewDao.selectReviewListByProductId(goodsNo);
    }

    @Override
    public ReviewDto findReview(Integer reviewNo) {
        return reviewDao.selectReview(reviewNo);
    }

    @Override
    public List<ReviewDto> findReviews(String userId) {
        return reviewDao.selectReviewListById(userId);
    }
}
