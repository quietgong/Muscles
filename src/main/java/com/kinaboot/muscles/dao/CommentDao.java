package com.kinaboot.muscles.dao;

import com.kinaboot.muscles.domain.CommentDto;

import java.util.List;

public interface CommentDao {
    int count() throws Exception;

    int deleteAll();

    int delete(Integer commentNo) throws Exception;

    int insert(CommentDto commentDto) throws Exception;

    CommentDto select(Integer commentNo) throws Exception;

    List<CommentDto> selectAll(Integer postNo) throws Exception;

    int update(CommentDto commentDto) throws Exception;
}
