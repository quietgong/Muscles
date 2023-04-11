package com.kinaboot.muscles.service;

import com.kinaboot.muscles.TestConfigure;
import com.kinaboot.muscles.dao.UserDao;
import com.kinaboot.muscles.domain.UserDto;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

public class UserServiceImplTest extends TestConfigure {
    @Autowired
    UserService userService;
    @Autowired
    UserDao userDao;

    @Test
    public void adminUserOutTest() throws Exception {
        int userCnt = userDao.selectAllUser().size();
        userService.removeUser("test1", null, "admin");
    }
}
