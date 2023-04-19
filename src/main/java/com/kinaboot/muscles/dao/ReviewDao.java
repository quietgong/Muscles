package com.kinaboot.muscles.dao;

import com.kinaboot.muscles.domain.ReviewDto;
import com.kinaboot.muscles.domain.ReviewImgDto;

import java.util.List;

public interface ReviewDao {
    List<ReviewDto> selectReviewListById(String userId);

    int insertReview(ReviewDto reviewDto);

    List<ReviewDto> selectReviewListByProductId(Integer goodsNo);

    ReviewDto selectReview(int orderNo, int goodsNo);
    ReviewDto selectReview(Integer reviewNo);

    int deleteReview(Integer reviewNo);

    int updateReview(ReviewDto reviewDto);

    int deleteGoodsReview(Integer goodsNo);

    List<ReviewDto> selectGoodsReview(Integer goodsNo);

    int deleteGoodsFaq(Integer goodsNo);

    int selectNewReviewNo();

    int insertReviewImg(ReviewImgDto reviewImgDto);

    int deleteReviewImg(String imgPath);
    int deleteReviewImg(int reviewNo);

    List<ReviewImgDto> selectReviewImg(int reviewNo, Integer goodsNo);
    List<ReviewImgDto> selectReviewImg(int reviewNo);
}
