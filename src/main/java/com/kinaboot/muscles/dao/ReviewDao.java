package com.kinaboot.muscles.dao;

import com.kinaboot.muscles.domain.ReviewDto;
import com.kinaboot.muscles.domain.ReviewImgDto;

import java.util.List;

public interface ReviewDao {
    List<ReviewDto> selectReviewListById(String userId);

    int insertReview(ReviewDto reviewDto);

    List<ReviewDto> selectReviewListByProductId(Integer goodsNo);

    ReviewDto selectReview(Integer orderNo, Integer goodsNo);

    ReviewDto selectReview(Integer reviewNo);

    int deleteReview(Integer reviewNo);

    int updateReview(ReviewDto reviewDto);

    int deleteGoodsReview(Integer goodsNo);

    List<ReviewDto> selectGoodsReview(Integer goodsNo);

    int selectNewReviewNo();

    int insertReviewImg(ReviewImgDto reviewImgDto);

    int deleteReviewImg(Integer reviewNo);

    List<ReviewImgDto> selectReviewImg(Integer reviewNo, Integer goodsNo);

    List<ReviewImgDto> selectReviewImg(Integer reviewNo);

    int deleteAll();
}
