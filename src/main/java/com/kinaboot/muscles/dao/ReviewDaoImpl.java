package com.kinaboot.muscles.dao;

import com.kinaboot.muscles.domain.ReviewDto;
import com.kinaboot.muscles.domain.ReviewImgDto;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class ReviewDaoImpl implements ReviewDao {
    @Autowired
    private SqlSession session;

    private static String namespace = "com.kinaboot.muscles.dao.reviewMapper.";

    @Override
    public int selectNewReviewNo() {
        return session.selectOne(namespace + "newReviewNo");
    }

    @Override
    public List<ReviewDto> selectReviewListByProductId(Integer goodsNo) {
        return session.selectList(namespace + "selectReviewByProductNo", goodsNo);
    }

    @Override
    public List<ReviewDto> selectGoodsReview(Integer goodsNo) {
        return session.selectList(namespace + "selectGoodsReview", goodsNo);
    }
    @Override
    public ReviewDto selectReview(Integer orderNo, Integer goodsNo) {
        Map<String, Integer> map = new HashMap<>();
        map.put("orderNo", orderNo);
        map.put("goodsNo", goodsNo);
        return session.selectOne(namespace + "selectReview", map);
    }

    @Override
    public ReviewDto selectReview(Integer reviewNo) {
        return session.selectOne(namespace + "selectReviewOne", reviewNo);
    }
    @Override
    public List<ReviewImgDto> selectReviewImg(Integer reviewNo, Integer goodsNo) {
        HashMap<String, Integer> map = new HashMap<>();
        map.put("reviewNo", reviewNo);
        map.put("goodsNo", goodsNo);
        return session.selectList(namespace + "selectReviewImg", map);
    }

    @Override
    public List<ReviewImgDto> selectReviewImg(Integer reviewNo) {
        return session.selectList(namespace + "selectReviewOneImg", reviewNo);
    }
    @Override
    public List<ReviewDto> selectReviewListById(String userId) {
        return session.selectList(namespace + "selectReviewById", userId);
    }
    @Override
    public int insertReview(ReviewDto reviewDto) {
        return session.insert(namespace + "insertReview", reviewDto);
    }

    @Override
    public int insertReviewImg(ReviewImgDto reviewImgDto) {
        return session.insert(namespace + "insertReviewImg", reviewImgDto);
    }

    @Override
    public int updateReview(ReviewDto reviewDto) {
        return session.update(namespace+"updateReview",reviewDto);
    }



    @Override
    public int deleteReview(Integer reviewNo) {
        return session.delete(namespace + "deleteReview", reviewNo);
    }

    @Override
    public int deleteGoodsReview(Integer goodsNo) {
        return session.delete(namespace + "deleteGoodsReview", goodsNo);
    }

    @Override
    public int deleteReviewImg(Integer reviewNo) {
        return session.delete(namespace + "deleteReviewImgs", reviewNo);
    }

    @Override
    public int deleteAll() {
        return session.delete(namespace + "deleteAll");
    }
}
