package com.kinaboot.muscles.dao;

import com.kinaboot.muscles.domain.PostImgDto;
import com.kinaboot.muscles.domain.PostDto;
import com.kinaboot.muscles.handler.SearchCondition;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;

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
    public int selectPostNo() {
        return session.selectOne(namespace + "selectPostNo");
    }

    @Override
    public List<PostImgDto> selectPostImg(Integer postNo) {
        return session.selectList(namespace + "selectPostImg", postNo);
    }

    @Override
    public void deleteAll() {
        session.delete(namespace + "deleteAll");
    }

    @Override
    public int delete(Integer postNo) throws Exception {
        return session.delete(namespace + "delete", postNo);
    }

    @Override
    public int delete(String userId) throws Exception {
        return session.delete(namespace + "deletePost", userId);
    }

    @Override
    public int deletePostImgs(Integer postNo) {
        return session.delete(namespace + "deletePostImgs", postNo);
    }

    @Override
    public int insert(PostDto postDto) throws Exception {
        return session.insert(namespace + "insert", postDto);
    }

    @Override
    public int insertPostImg(PostImgDto postImgDto) {
        return session.insert(namespace + "insertPostImg", postImgDto);
    }

    @Override
    public List<PostDto> searchResult(SearchCondition sc) {
        return session.selectList(namespace + "searchResult", sc);
    }
    @Override
    public List<PostDto> searchResult(String userId, SearchCondition sc) {
        HashMap<String, Object> map = new HashMap<>();
        map.put("userId", userId);
        map.put("sc", sc);
        return session.selectList(namespace + "searchResult", map);
    }

    @Override
    public Integer searchResultCnt(SearchCondition sc) {
        return session.selectOne(namespace + "searchResultCnt", sc);
    }

    @Override
    public List<PostDto> selectAll(String type) throws Exception {
        return session.selectList(namespace + "selectAll", type);
    }

    @Override
    public List<PostDto> selectAllByUser(String userId) {
        return session.selectList(namespace + "selectAllByUser", userId);
    }

    @Override
    public PostDto select(Integer postNo) throws Exception {
        return session.selectOne(namespace + "select", postNo);
    }

    @Override
    public int update(PostDto postDto) throws Exception {
        return session.update(namespace + "update", postDto);
    }

    @Override
    public int increaseViewCnt(Integer postNo) {
        return session.update(namespace + "increaseViewCnt", postNo);
    }

    @Override
    public int deletePostImg(String imgPath) {
        return session.delete(namespace + "deletePostImg", imgPath);
    }
}
