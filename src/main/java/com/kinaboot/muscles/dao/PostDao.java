package com.kinaboot.muscles.dao;

import com.kinaboot.muscles.domain.PostImgDto;
import com.kinaboot.muscles.handler.PageHandler;
import com.kinaboot.muscles.domain.PostDto;
import com.kinaboot.muscles.handler.SearchCondition;

import java.util.List;

public interface PostDao {
    int count(String type) throws Exception // T selectOne(String statement)
    ;

    void deleteAll() // int delete(String statement)
    ;

    int delete(Integer postNo) throws Exception // int delete(String statement, Object parameter)
    ;
    int delete(String userId) throws Exception // int delete(String statement, Object parameter)
    ;
    int insert(PostDto postDto) throws Exception // int insert(String statement, Object parameter)
    ;

    PostDto select(Integer postNo) throws Exception // T selectOne(String statement, Object parameter)
    ;

    List<PostDto> selectAll(String type) throws Exception // List<E> selectList(String statement)
    ;

    List<PostDto> selectAllByUser(String userId) throws Exception // List<E> selectList(String statement)
    ;

    List<PostDto> selectPage(PageHandler ph) throws Exception // List<E> selectList(String statement, Object parameter)
    ;

    List<PostDto> searchResult(SearchCondition sc) throws Exception // List<E> selectList(String statement, Object parameter)
    ;

    List<PostDto> searchResult(String userId, SearchCondition sc);

    Integer searchResultCnt(SearchCondition sc) throws Exception;

    int update(PostDto dto) throws Exception // int update(String statement, Object parameter)
    ;

    int increaseViewCnt(Integer postNo) throws Exception // int update(String statement, Object parameter)
    ;

    int selectPostNo();

    int insertPostImg(PostImgDto postImgDto);

    List<PostImgDto> selectPostImg(Integer postNo);

    int deletePostImgs(Integer postNo);

    int deletePostImg(String imgPath);
}
