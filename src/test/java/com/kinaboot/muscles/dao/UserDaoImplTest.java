package com.kinaboot.muscles.dao;

import com.kinaboot.muscles.domain.UserDto;
import org.junit.After;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.Date;

import static org.junit.Assert.*;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
public class UserDaoImplTest  {

    @Autowired
    UserDao userDao;

//    @Test
//    public void selectUserTest() {
//        int rowCnt = userDao.searchIdCnt("admin");
//        System.out.println("rowCnt = " + rowCnt);
//    }@Test
//    public void updateUserTest() {
//        int rowCnt = userDao.searchIdCnt("admin");
//        System.out.println("rowCnt = " + rowCnt);
//    }

    @Test
    public void insertUserTest() {
        deleteAll();

        for (int i = 1; i <= 20 ; i++) {
            UserDto userDto = new UserDto("test"+i, "1234","test@test.com","01012345678","test",0);
            userDao.insertUser(userDto);
        }
        assert (userDao.count() == 20);
    }
    @Test
    public void deleteAll(){
        userDao.deleteAll();
    }
}