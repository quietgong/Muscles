package com.kinaboot.muscles.dao;

import com.kinaboot.muscles.domain.PostDto;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import static org.junit.Assert.*;
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
public class PostDaoImplTest {
    @Autowired
    PostDao postDao;

    @Test
    public void insertTest() throws Exception{
        postDao.deleteAll();
        int insertCnt =100;
        String[] option = {"notice", "community"};
        for (int i = 1; i <= insertCnt; i++){
            PostDto postDto = new PostDto(option[i%2],"title"+i,option[i%2]+i,"test"+i);
            postDao.insert(postDto, option[i%2]);
        }
        assert (postDao.count() == insertCnt);
    }
    @Test
    public void selectPostTest() throws Exception{
        postDao.deleteAll();
        int insertCnt =100;
        String[] option = {"notice", "community"};
        for (int i = 1; i <= insertCnt; i++){
            PostDto postDto = new PostDto(option[i%2],"title"+i,option[i%2]+i,"test"+i);
            postDao.insert(postDto, option[i%2]);
        }
        assert (postDao.count() == insertCnt);
    }
    @Test
    public void updatePostTest() throws Exception{
        postDao.deleteAll();
        int insertCnt =100;
        String[] option = {"notice", "community"};
        for (int i = 1; i <= insertCnt; i++){
            PostDto postDto = new PostDto(option[i%2],"title"+i,option[i%2]+i,"test"+i);
            postDao.insert(postDto, option[i%2]);
        }
        assert (postDao.count() == insertCnt);
    }
    @Test
    public void deletePostTest() throws Exception{
        postDao.deleteAll();
        int insertCnt =100;
        String[] option = {"notice", "community"};
        for (int i = 1; i <= insertCnt; i++){
            PostDto postDto = new PostDto(option[i%2],"title"+i,option[i%2]+i,"test"+i);
            postDao.insert(postDto, option[i%2]);
        }
        assert (postDao.count() == insertCnt);
    }

}