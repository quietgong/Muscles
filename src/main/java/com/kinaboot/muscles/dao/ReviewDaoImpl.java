package com.kinaboot.muscles.dao;

import com.kinaboot.muscles.domain.ReviewDto;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class ReviewDaoImpl implements ReviewDao{
    @Autowired
    private SqlSession session;
    private static String namespace = "com.kinaboot.muscles.dao.reviewMapper.";
    @Override
    public List<ReviewDto> selectReviewListById(String userId) {
        return session.selectList(namespace+"selectReviewById", userId);
    }
}
