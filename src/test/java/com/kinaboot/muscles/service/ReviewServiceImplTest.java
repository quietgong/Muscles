//package com.kinaboot.muscles.service;
//
//import com.kinaboot.muscles.TestConfigure;
//import com.kinaboot.muscles.dao.ReviewDao;
//import com.kinaboot.muscles.domain.ReviewDto;
//import com.kinaboot.muscles.domain.ReviewImgDto;
//import org.junit.After;
//import org.junit.Before;
//import org.junit.Test;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Service;
//import org.springframework.transaction.annotation.Transactional;
//
//import java.util.List;
//
//import static org.junit.Assert.*;
//
//public class ReviewServiceImplTest extends TestConfigure {
//    @Autowired
//    ReviewDao reviewDao;
//
//    @Before
//    public void setUp() throws Exception {
//    }
//
//    @After
//    public void tearDown() throws Exception {
//    }
//
//    @Test
//    public void findReview() {
//        reviewDao.selectReview(orderNo, goodsNo);
//    }
//
//    @Test
//    public void modifyReview() {
//        reviewDao.deleteReviewImg(reviewDto.getReviewNo()); // 해당 reviewNo 이미지 전체 삭제
//        List<ReviewImgDto> reviewImgDtoList = reviewDto.getReviewImgDtoList();
//        for(ReviewImgDto reviewImgDto : reviewImgDtoList)
//            reviewDao.insertReviewImg(reviewImgDto);
//        reviewDao.updateReview(reviewDto);
//    }
//
//    @Test
//    public void removeReview() {
//        reviewDao.deleteReviewImg(reviewNo);
//        reviewDao.deleteReview(reviewNo);
//    }
//
//    @Test
//    public void addReview() {
//        List<ReviewImgDto> reviewImgDtoList = reviewDto.getReviewImgDtoList();
//        if(reviewImgDtoList!=null){
//            for(ReviewImgDto reviewImgDto : reviewImgDtoList){
//                reviewImgDto.setReviewNo(reviewDao.selectNewReviewNo());
//                reviewDao.insertReviewImg(reviewImgDto);
//            }
//        }
//        reviewDao.insertReview(reviewDto);
//    }
//
//    @Test
//    public void findReviews() {
//        List<ReviewDto> reviewDtoList = reviewDao.selectReviewListById(userId);
//        for(ReviewDto reviewDto: reviewDtoList)
//            reviewDto.setReviewImgDtoList(reviewDao.selectReviewImg(reviewDto.getReviewNo()));
//        reviewDtoList;
//    }
//
//    @Test
//    public void testFindReviews() {
//        reviewDao.selectReviewListByProductId(goodsNo);
//
//    }
//
//    @Test
//    public void testFindReview() {
//        ReviewDto reviewDto = reviewDao.selectReview(reviewNo);
//        reviewDto.setReviewImgDtoList(reviewDao.selectReviewImg(reviewNo));
//        reviewDto;
//    }
//
//    @Test
//    public void removeReviewImg() {
//        reviewDao.deleteReviewImg(imgPath);
//
//    }
//
//    @Test
//    public void findReviewImg() {
//        reviewDao.selectReviewImg(reviewNo, goodsNo);
//    }
//}
//
//
