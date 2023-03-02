package com.kinaboot.muscles.service;

import com.kinaboot.muscles.dao.UserDao;
import com.kinaboot.muscles.domain.UserDto;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class UserServiceImpl implements UserService{
    @Autowired
    UserDao userDao;

    @Override
    public int modifyUserInfo(String[] userInfo) {
        return userDao.updateUser(userInfo);
    }

    @Override
    public int leaveUser(Map map) {
        userDao.insertLeave(map);
        return userDao.deleteUser((String) map.get("userId"));
    }

    @Override
    public int modifyUserPassword(String userId, String newPassword) {
        return userDao.updateUserPassword(userId, newPassword);
    }

    @Override
    public List<UserDto> getList(Integer offset, Integer pageSize) throws Exception {
        return null;
    }

    @Override
    public UserDto read(String userId) throws Exception {
        return userDao.selectUser(userId);
    }

    @Override
    public int create(UserDto userDto) throws Exception {
        return 0;
    }

    @Override
    public int modify(UserDto userDto) throws Exception {
        return 0;
    }

    @Override
    public int remove(String id) throws Exception {
        return 0;
    }
}
