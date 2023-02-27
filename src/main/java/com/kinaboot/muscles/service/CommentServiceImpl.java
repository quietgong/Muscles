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
    public int getCount() throws Exception {
        return commentDao.count();
    }

    @Override
    public int write(CommentDto commentDto) throws Exception {
        return commentDao.insert(commentDto);
    }

    @Override
    public int modify(CommentDto commentDto) throws Exception {
        return commentDao.update(commentDto);
    }

    @Override
    public int remove(Integer commentNo, Integer postNo, String userId) throws Exception {
        return commentDao.delete(commentNo,postNo,userId);
    }

    @Override
    public List<CommentDto> getList(Integer postNo) throws Exception {
        return commentDao.selectAll(postNo);
    }
}
