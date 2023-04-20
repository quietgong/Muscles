package com.kinaboot.muscles.dao;

import com.kinaboot.muscles.domain.PostImgDto;
import com.kinaboot.muscles.handler.PageHandler;
import com.kinaboot.muscles.domain.PostDto;
import com.kinaboot.muscles.handler.SearchCondition;

import java.util.List;

public interface PostDao {
    int count(String type) throws Exception;
    int delete(Integer postNo) throws Exception;

    int delete(String userId) throws Exception;

    int insert(PostDto postDto) throws Exception;

    PostDto select(Integer postNo) throws Exception;

    List<PostDto> selectAll(String type) throws Exception;

    List<PostDto> selectAllByUser(String userId) throws Exception;

    List<PostDto> searchResult(SearchCondition sc) throws Exception;

    Integer searchResultCnt(SearchCondition sc) throws Exception;

    int update(PostDto dto) throws Exception;

    int increaseViewCnt(Integer postNo) throws Exception;

    int selectPostNo();

    int insertPostImg(PostImgDto postImgDto);

    List<PostImgDto> selectPostImg(Integer postNo);

    int deletePostImgs(Integer postNo);

    int deletePostImg(String imgPath);
    int deleteAll();
}
