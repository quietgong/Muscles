package com.kinaboot.muscles.dao;

import com.kinaboot.muscles.domain.ReviewDto;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class ReviewDaoImpl implements ReviewDao {
    @Override
    public List<ReviewDto> selectReviewListByProductId(Integer goodsNo) {
        return session.selectList(namespace + "selectReviewByProductNo", goodsNo);
    }

    @Override
    public int deleteReview(Integer reviewNo) {
        return session.delete(namespace + "deleteReview", reviewNo);
    }

    @Override
    public int updateReview(ReviewDto reviewDto) {
        return session.update(namespace+"updateReview",reviewDto);
    }

    @Override
    public List<ReviewDto> selectGoodsReview(Integer goodsNo) {
        return session.selectList(namespace + "selectGoodsReview", goodsNo);
    }

    @Override
    public int deleteGoodsReview(Integer goodsNo) {
        return session.delete(namespace + "deleteGoodsReview", goodsNo);
    }

    @Override
    public ReviewDto selectReview(int orderNo, int goodsNo) {
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
    public int insertReview(ReviewDto reviewDto) {
        return session.insert(namespace + "insertReview", reviewDto);
    }

    @Autowired
    private SqlSession session;
    private static String namespace = "com.kinaboot.muscles.dao.reviewMapper.";

    @Override
    public List<ReviewDto> selectReviewListById(String userId) {
        return session.selectList(namespace + "selectReviewById", userId);
    }
}
