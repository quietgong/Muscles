package com.kinaboot.muscles.dao;

import com.kinaboot.muscles.domain.PageHandler;
import com.kinaboot.muscles.domain.PostDto;
import com.kinaboot.muscles.domain.SearchCondition;
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
    public int count(String type) throws Exception {
        return session.selectOne(namespace + "count", type);
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
        return session.insert(namespace + "insert", map);
    }

    @Override
    public List<PostDto> searchResult(SearchCondition sc) throws Exception {
        return session.selectList(namespace+"searchResult", sc);
    }

    @Override
    public int searchResultCnt(SearchCondition sc) throws Exception {
        return session.selectOne(namespace + "searchResultCnt",sc);
    }

    @Override
    public List<PostDto> selectAll(String type) throws Exception {
        return session.selectList(namespace + "selectAll", type);
    }

    @Override
    public List<PostDto> selectAllByUser(String userId) throws Exception {
        return session.selectList(namespace + "selectAllByUser", userId);
    }

    @Override
    public PostDto select(Integer postNo) throws Exception {
        return session.selectOne(namespace + "select", postNo);
    }

    @Override
    public List<PostDto> selectPage(PageHandler ph){
        int limit = (ph.getSc().getPage()-1)*ph.getPageSize();
        return session.selectList(namespace+"selectPage",limit);
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
