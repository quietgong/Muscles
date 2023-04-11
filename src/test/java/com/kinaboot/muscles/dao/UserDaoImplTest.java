package com.kinaboot.muscles.dao;

import com.kinaboot.muscles.TestConfigure;
import com.kinaboot.muscles.domain.UserDto;
import com.kinaboot.muscles.service.UserService;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class UserDaoImplTest extends TestConfigure {
    @Autowired
    private SqlSession session;
    private static String namespace = "com.kinaboot.muscles.dao.userMapper.";
    @Autowired
    UserDao userDao;
    @Autowired
    UserService userService;
    @Autowired
    BCryptPasswordEncoder passwordEncoder;

    @Test
    public void registerUserTest() {
        int userCnt = userDao.selectAllUser().size();

    }



    @Test
    public void insertUserTest() {
        deleteAll();

        for (int i = 1; i <= 20; i++) {
            UserDto userDto = new UserDto("test" + i, passwordEncoder.encode("1234"), "test" + i + "@test.com", "01012345678", "기본주소", "상세주소", 0);
            userDao.insertUser(userDto);
        }
        UserDto userDto = new UserDto("admin", passwordEncoder.encode("1234"), "admin@test.com", "01012345678", "기본주소", "상세주소", 0);
        userDao.insertUser(userDto);
        assert (userDao.count() == 20 + 1);
    }

    @Test
    public void deleteAll() {
        userDao.deleteAll();
    }

    @Test
    public void recommendPointTest() {
        String userId = "test9";
        String recommendId = "test8";
        userDao.insertRecommendEventCoupon(userId, recommendId);
    }

    @Test
    public void getCouponTest() {
        String userId = "none";
    }
}