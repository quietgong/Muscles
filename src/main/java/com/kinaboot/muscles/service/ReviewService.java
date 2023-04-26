package com.kinaboot.muscles.service;

import com.kinaboot.muscles.domain.ReviewDto;
import com.kinaboot.muscles.domain.ReviewImgDto;

import java.util.List;

public interface ReviewService {
    List<ReviewDto> findReviews(String userId);

    List<ReviewDto> findReviews(Integer goodsNo);

    ReviewDto findReview(Integer reviewNo);

    ReviewDto findReview(Integer orderNo, Integer goodsNo);

    int addReview(ReviewDto reviewDto);

    int removeReview(Integer reviewNo);

    int modifyReview(ReviewDto reviewDto);

    List<ReviewImgDto> findReviewImg(Integer reviewNo, Integer goodsNo);
}
