package com.kinaboot.muscles.service;

import com.kinaboot.muscles.domain.ReviewDto;

import java.util.List;

public interface ReviewService {
    List<ReviewDto> findReviews(String userId);
    List<ReviewDto> findReviews(Integer goodsNo);
    ReviewDto findReview(Integer reviewNo);
    ReviewDto findReview(int orderNo, int goodsNo);
    int addReview(ReviewDto reviewDto);
    int removeReview(Integer reviewNo);
    int modifyReview(ReviewDto reviewDto);
}
