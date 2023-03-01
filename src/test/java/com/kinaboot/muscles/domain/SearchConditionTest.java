package com.kinaboot.muscles.domain;

import com.kinaboot.muscles.dao.PostDao;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

import static org.junit.Assert.*;
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
public class SearchConditionTest {
    @Autowired
    PostDao postDao;
    @Test
    public void searchResultCntTest() throws Exception {
        // title1 : 12
        SearchCondition sc = new SearchCondition("T", "title1");
        System.out.println("sc = " + sc);
        int rowCnt = postDao.searchResultCnt(sc);
        assert (rowCnt==12);
    }
    @Test
    public void searchResultTest() throws Exception {
        // title1 : 12
        SearchCondition sc = new SearchCondition("T", "title1");
        List<PostDto> list = postDao.searchResult(sc);
        System.out.println("list = " + list);
    }

}