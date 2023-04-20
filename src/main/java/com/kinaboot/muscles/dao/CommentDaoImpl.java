package com.kinaboot.muscles.dao;

import com.kinaboot.muscles.domain.CommentDto;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class CommentDaoImpl implements CommentDao {
    @Autowired
    private SqlSession session;

    private static String namespace = "com.kinaboot.muscles.dao.commentMapper.";

    @Override
    public int count() throws Exception {
        return session.selectOne(namespace + "count");
    }

    @Override
    public CommentDto select(Integer commentNo) throws Exception {
        return session.selectOne(namespace + "select", commentNo);
    }

    @Override
    public List<CommentDto> selectAll(Integer postNo) throws Exception {
        return session.selectList(namespace + "selectAll", postNo);
    }

    @Override
    public int insert(CommentDto commentDto) throws Exception {
        return session.insert(namespace + "insert", commentDto);
    }

    @Override
    public int update(CommentDto commentDto) throws Exception {
        return session.update(namespace + "update", commentDto);
    }

    @Override
    public int deleteAll() {
        return session.delete(namespace + "deleteAll");
    }

    @Override
    public int deleteComment(Integer commentNo) {
        return session.delete(namespace + "deleteComment", commentNo);
    }

    @Override
    public int deleteComments(String userId) {
        return session.delete(namespace + "deleteComments", userId);
    }

    @Override
    public int deletePost(Integer postNo) {
        return session.delete(namespace + "deletePost", postNo);
    }
}
