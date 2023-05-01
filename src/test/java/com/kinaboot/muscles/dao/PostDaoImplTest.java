package com.kinaboot.muscles.dao;

import com.kinaboot.muscles.TestConfigure;
import com.kinaboot.muscles.domain.PostDto;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.Random;

import static org.junit.Assert.*;

public class PostDaoImplTest extends TestConfigure {
    @Autowired
    PostDao postDao;
    @Test
    public void insertPost() throws Exception {
        for (int i = 1; i <= 100; i++) {
            String userId = "admin";
            PostDto postDto = new PostDto();
            postDto.setUserId(userId);
            postDto.setTitle(i+"번째 공지사항 입니다.");
            postDto.setContent(i+"번째 내용");
            postDto.setType("notice");
            postDao.insert(postDto);
        }
    }
}