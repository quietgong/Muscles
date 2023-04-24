package com.kinaboot.muscles.dao;

import com.kinaboot.muscles.TestConfigure;
import com.kinaboot.muscles.domain.UserDto;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import static org.junit.Assert.*;

public class UserDaoImplTest extends TestConfigure {
    @Autowired
    UserDao userDao;
    @Autowired
    BCryptPasswordEncoder passwordEncoder;
    @Test
    public void insertUser(){
        for (int i = 1; i <= 100; i++) {
            UserDto userDto = new UserDto();
            userDto.setUserId("user"+i);
            userDto.setPassword(passwordEncoder.encode("1234"));
            userDto.setEmail("user"+i+"@test.com");
            userDto.setPoint(10000);
            userDto.setAddress1("테스트 시");
            userDto.setAddress2("테스트 동네");
            userDao.insertUser(userDto);
        }
    }
}