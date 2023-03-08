package com.kinaboot.muscles.service;

import com.kinaboot.muscles.domain.ReviewDto;

import java.util.List;

public interface ReviewService {
    List<ReviewDto> getReviewListById(String userId);

    int createReview(List<ReviewDto> reviewDtoList);
}
