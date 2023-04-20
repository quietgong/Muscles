package com.kinaboot.muscles.service;

import com.kinaboot.muscles.dao.ReviewDao;
import com.kinaboot.muscles.domain.GoodsDto;
import com.kinaboot.muscles.domain.GoodsImgDto;
import com.kinaboot.muscles.domain.ReviewDto;
import com.kinaboot.muscles.domain.ReviewImgDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
        saveReviewImgs(reviewDto);
        return reviewDao.updateReview(reviewDto);
    }
    private void saveReviewImgs(ReviewDto reviewDto) {
        reviewDao.deleteReviewImg(reviewDto.getReviewNo()); // 해당 rievewNo 이미지 전체 삭제
        List<ReviewImgDto> reviewImgDtoList = reviewDto.getReviewImgDtoList();
        for(ReviewImgDto reviewImgDto : reviewImgDtoList){
            reviewDao.insertReviewImg(reviewImgDto);
        }
    }

    @Override
    public int removeReview(Integer reviewNo) {
        reviewDao.deleteReviewImg(reviewNo);
        return reviewDao.deleteReview(reviewNo);
    }

    @Override
    public int addReview(ReviewDto reviewDto) {
        System.out.println("reviewDto = " + reviewDto);
        List<ReviewImgDto> reviewImgDtoList = reviewDto.getReviewImgDtoList();
        if(reviewImgDtoList!=null){
            for(ReviewImgDto reviewImgDto : reviewImgDtoList){
                reviewImgDto.setReviewNo(reviewDao.selectNewReviewNo());
                reviewDao.insertReviewImg(reviewImgDto);
            }
        }
        return reviewDao.insertReview(reviewDto);
    }

    @Override
    public List<ReviewDto> findReviews(Integer goodsNo) {
        return reviewDao.selectReviewListByProductId(goodsNo);
    }

    @Override
    public ReviewDto findReview(Integer reviewNo) {
        ReviewDto reviewDto = reviewDao.selectReview(reviewNo);
        reviewDto.setReviewImgDtoList(reviewDao.selectReviewImg(reviewNo));
        return reviewDto;
    }

    @Override
    public List<ReviewDto> findReviews(String userId) {
        List<ReviewDto> reviewDtoList = reviewDao.selectReviewListById(userId);
        for(ReviewDto reviewDto: reviewDtoList){
            reviewDto.setReviewImgDtoList(reviewDao.selectReviewImg(reviewDto.getReviewNo()));
        }
        return reviewDtoList;
    }

    @Override
    public int removeReviewImg(String imgPath) {
        return reviewDao.deleteReviewImg(imgPath);
    }

    @Override
    public List<ReviewImgDto> findReviewImg(int reviewNo, Integer goodsNo) {
        return reviewDao.selectReviewImg(reviewNo, goodsNo);
    }
}
