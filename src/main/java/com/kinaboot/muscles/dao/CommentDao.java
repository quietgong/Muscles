package com.kinaboot.muscles.dao;

import com.kinaboot.muscles.domain.CommentDto;

import java.util.List;

public interface CommentDao {
    int count() throws Exception;
    List<CommentDto> selectAll(Integer postNo) throws Exception;
    CommentDto select(Integer commentNo) throws Exception;
    int insert(CommentDto commentDto) throws Exception;
    int update(CommentDto commentDto) throws Exception;
    int deleteComment(Integer commentNo) throws Exception;
    int deleteComments(String userId) throws Exception;
    int deletePost(Integer postNo);
    int deleteAll();
}
