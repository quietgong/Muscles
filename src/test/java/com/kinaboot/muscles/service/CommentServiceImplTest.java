package com.kinaboot.muscles.service;

import com.kinaboot.muscles.TestConfigure;
import com.kinaboot.muscles.dao.CommentDao;
import com.kinaboot.muscles.domain.CommentDto;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Disabled;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;
import java.util.Optional;

import static org.junit.Assert.*;

public class CommentServiceImplTest extends TestConfigure {
    @Autowired
    CommentDao commentDao;

    private String userId = "test";

    @Test
    public void addComment() throws Exception {
        int before = commentDao.count();
        CommentDto commentDto = new CommentDto();
        commentDao.insert(commentDto);
        int after = commentDao.count();
        assertEquals(before + 1, after);
    }

    @Test
    public void findComments() throws Exception {
        List<CommentDto> commentDtoList = commentDao.selectAll(1);
        assertEquals(
                Optional.ofNullable(commentDtoList.get(0).getPostNo()),
                Optional.ofNullable(1));
    }

    @Test
    public void removeCommentNo() throws Exception {
        int before = commentDao.count();
        int commentNo = commentDao.selectAll(1).get(0).getCommentNo();
        commentDao.delete(commentNo);
        int after = commentDao.count();
        assertEquals(before - 1, after);
    }

    @Test
    public void modifyComment() throws Exception {
        int commentNo = commentDao.selectAll(1).get(0).getCommentNo();
        assertEquals(commentDao.select(commentNo).getContent(), "testContent");
        CommentDto commentDto = commentDao.select(commentNo);
        commentDto.setContent("update");
        commentDao.update(commentDto);
        assertEquals(commentDao.select(commentNo).getContent(), "update");
    }

    @Before
    public void before() throws Exception {
        System.out.println("Before Each@");
        commentDao.deleteAll();
        CommentDto commentDto = new CommentDto();
        commentDto.setCommentNo(1);
        commentDto.setPostNo(1);
        commentDto.setUserId("test");
        commentDto.setContent("testContent");
        commentDao.insert(commentDto);
    }
    @After
    public void after(){
        commentDao.deleteAll();
    }
}