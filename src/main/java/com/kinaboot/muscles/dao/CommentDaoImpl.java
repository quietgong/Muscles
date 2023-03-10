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
    public int deleteAll() {
        return session.delete(namespace + "deleteAll");
    }

    @Override
    public int delete(Integer commentNo, Integer postNo, String userId) throws Exception {
        Map map = new HashMap<>();
        map.put("commentNo", commentNo);
        map.put("postNo", postNo);
        map.put("userId", userId);
        return session.delete(namespace + "delete", map);
    }

    @Override
    public int insert(CommentDto commentDto) throws Exception {
        return session.insert(namespace + "insert", commentDto);
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
    public int update(CommentDto commentDto) throws Exception {
        return session.update(namespace + "update", commentDto);
    }
}
