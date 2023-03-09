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
    public List<ReviewDto> selectReviewListByProductId(Integer productNo) {
        return session.selectList(namespace + "selectReviewByProductNo", productNo);
    }

    @Override
    public int deleteReview(Integer orderNo, Integer productNo, String userId) {
        Map map = new HashMap();
        map.put("orderNo", orderNo);
        map.put("productNo", productNo);
        map.put("userId", userId);
        return session.delete(namespace + "deleteReview", map);
    }

    @Override
    public ReviewDto selectReview(int orderNo, int productNo) {
        Map map = new HashMap();
        map.put("orderNo", orderNo);
        map.put("productNo", productNo);
        return session.selectOne(namespace + "selectReview", map);
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
