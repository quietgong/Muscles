package com.kinaboot.muscles.dao;

import com.kinaboot.muscles.domain.CommentDto;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
public class CommentDaoImplTest {
    @Autowired
    CommentDao commentDao;

    @Test
    public void insertCommentTest() throws Exception{
        commentDao.deleteAll();
        int insertCnt =100;
        for (int i = 1; i <= insertCnt; i++){
            CommentDto commentDto = new CommentDto(insertCnt-i,"kinaboot","test_comment");
            commentDao.insert(commentDto);
        }
        assert (commentDao.count() == insertCnt);
    }
    @Test
    public void selectCommentTest() throws Exception{
        commentDao.deleteAll();
        int insertCnt =100;
        for (int i = 1; i <= insertCnt; i++){
            CommentDto commentDto = new CommentDto(insertCnt-i,"kinaboot","test_comment");
            commentDao.insert(commentDto);
        }
        assert (commentDao.count() == insertCnt);
    }
    @Test
    public void updateCommentTest() throws Exception{
        commentDao.deleteAll();
        int insertCnt =100;
        for (int i = 1; i <= insertCnt; i++){
            CommentDto commentDto = new CommentDto(insertCnt-i,"kinaboot","test_comment");
            commentDao.insert(commentDto);
        }
        assert (commentDao.count() == insertCnt);
    }
    @Test
    public void deleteCommentTest() throws Exception{
        commentDao.deleteAll();
        int insertCnt =100;
        for (int i = 1; i <= insertCnt; i++){
            CommentDto commentDto = new CommentDto(insertCnt-i,"kinaboot","test_comment");
            commentDao.insert(commentDto);
        }
        assert (commentDao.count() == insertCnt);
    }

}
