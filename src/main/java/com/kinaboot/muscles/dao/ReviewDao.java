package com.kinaboot.muscles.dao;

import com.kinaboot.muscles.domain.ReviewDto;

import java.util.List;

public interface ReviewDao {
    List<ReviewDto> selectReviewListById(String userId);

    int insertReview(ReviewDto reviewDto);

    List<ReviewDto> selectReviewListByProductId(Integer goodsNo);

    ReviewDto selectReview(int orderNo, int goodsNo);
    ReviewDto selectReview(Integer reviewNo);

    int deleteReview(Integer reviewNo);

    int updateReview(ReviewDto reviewDto);
}
