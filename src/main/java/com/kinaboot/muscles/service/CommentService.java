package com.kinaboot.muscles.service;

import com.kinaboot.muscles.domain.CommentDto;

import java.util.List;

public interface CommentService {
    List<CommentDto> findComments(Integer bno) throws Exception;
    int addComment(CommentDto CommentDto) throws Exception;
    int modifyComment(CommentDto CommentDto) throws Exception;
    int removeComment(Integer cno) throws Exception;
    int removeComment(String userId) throws Exception;
}
