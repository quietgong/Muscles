package com.kinaboot.muscles.service;

import com.kinaboot.muscles.domain.ReviewDto;

import java.util.List;

public interface ReviewService {
    List<ReviewDto> getReviewListById(String userId);

    int createReview(ReviewDto reviewDto);

    List<ReviewDto> getReviewListByProductNo(Integer productNo);

    ReviewDto getReviewOne(int orderNo, int productNo);

    int removeReview(Integer orderNo, Integer productNo, String userId);
}
