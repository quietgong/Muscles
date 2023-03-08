package com.kinaboot.muscles.dao;

import com.kinaboot.muscles.domain.ReviewDto;

import java.util.List;

public interface ReviewDao {
    List<ReviewDto> selectReviewListById(String userId);

    int insertReview(List<ReviewDto> reviewDtoList);
}
