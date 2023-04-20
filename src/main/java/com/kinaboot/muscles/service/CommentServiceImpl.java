package com.kinaboot.muscles.service;

import com.kinaboot.muscles.dao.CommentDao;
import com.kinaboot.muscles.domain.CommentDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class CommentServiceImpl implements CommentService{
    @Autowired
    CommentDao commentDao;
    @Override
    public List<CommentDto> findComments(Integer postNo) throws Exception {
        return commentDao.selectAll(postNo);
    }

    @Override
    public int removeComment(String userId) throws Exception {
        return commentDao.delete(userId);
    }
    @Override
    public int removeComment(Integer commentNo) throws Exception {
        return commentDao.delete(commentNo);
    }

    @Override
    public int addComment(CommentDto commentDto) throws Exception {
        return commentDao.insert(commentDto);
    }

    @Override
    public int modifyComment(CommentDto commentDto) throws Exception {
        return commentDao.update(commentDto);
    }
}
