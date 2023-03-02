package com.kinaboot.muscles.dao;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
public class CartDaoImplTest {
    @Autowired
    CartDao cartDao;
    @Test
    public void InsertTest(){
        for (int i = 3; i < 103; i++) {
            cartDao.add("test7", String.valueOf(i), String.valueOf(12));
        }
    }
}
