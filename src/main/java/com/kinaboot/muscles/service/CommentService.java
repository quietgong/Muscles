package com.kinaboot.muscles.service;

import com.kinaboot.muscles.domain.CommentDto;

import java.util.List;

public interface CommentService {
    int getCount() throws Exception;

    int write(CommentDto CommentDto) throws Exception;

    int modify(CommentDto CommentDto) throws Exception;

    int remove(Integer cno) throws Exception;

    List<CommentDto> getList(Integer bno) throws Exception;
}
