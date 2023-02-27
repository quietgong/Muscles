package com.kinaboot.muscles.dao;

import com.kinaboot.muscles.domain.PostDto;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class PostDaoImpl implements PostDao {
    @Autowired
    private SqlSession session;
    private static String namespace = "com.kinaboot.muscles.dao.postMapper.";


    @Override
    public int count() throws Exception {
        return session.selectOne(namespace + "count");
    }

    @Override
    public void deleteAll() {
        session.delete(namespace + "deleteAll");
    }

    @Override
    public int delete(Integer postNo, String userId) throws Exception {
        Map map = new HashMap();
        map.put("postNo", postNo);
        map.put("userId", userId);
        return session.delete(namespace+"delete", map);
    }

    @Override
    public int insert(PostDto postDto, String type) throws Exception {
        Map map = new HashMap();
        map.put("postDto", postDto);
        map.put("type", type);
        session.insert(namespace + "insert", map);
        return 0;
    }

    @Override
    public List<PostDto> selectAll(String type) throws Exception {
        return session.selectList(namespace + "selectAll", type);
    }

    @Override
    public List<PostDto> selectAll(Integer offset, Integer pageSize) throws Exception {
        return null;
    }

    @Override
    public PostDto select(Integer postNo) throws Exception {
        return session.selectOne(namespace + "select", postNo);
    }

    @Override
    public List<PostDto> selectPage(Map map) throws Exception {
        return null;
    }

    @Override
    public int update(PostDto postDto) throws Exception {
        return session.update(namespace+"update", postDto);
    }

    @Override
    public int increaseViewCnt(Integer postNo) throws Exception {
        return session.update(namespace+"increaseViewCnt", postNo);
    }
}
