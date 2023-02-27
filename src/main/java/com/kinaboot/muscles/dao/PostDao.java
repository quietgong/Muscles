package com.kinaboot.muscles.dao;

import com.kinaboot.muscles.domain.PageHandler;
import com.kinaboot.muscles.domain.PostDto;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;
public interface PostDao {
    int count(String type) throws Exception // T selectOne(String statement)
    ;

    void deleteAll() // int delete(String statement)
    ;

    int delete(Integer postNo, String writer) throws Exception // int delete(String statement, Object parameter)
    ;

    int insert(PostDto postDto, String type) throws Exception // int insert(String statement, Object parameter)
    ;

    PostDto select(Integer postNo) throws Exception // T selectOne(String statement, Object parameter)
    ;

    List<PostDto> selectAll(String type) throws Exception // List<E> selectList(String statement)
    ;

    List<PostDto> selectPage(PageHandler ph) throws Exception // List<E> selectList(String statement, Object parameter)
    ;

    int update(PostDto dto) throws Exception // int update(String statement, Object parameter)
    ;

    int increaseViewCnt(Integer postNo) throws Exception // int update(String statement, Object parameter)
    ;

}
