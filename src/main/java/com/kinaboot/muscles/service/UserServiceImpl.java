package com.kinaboot.muscles.service;

import com.kinaboot.muscles.dao.UserDao;
import com.kinaboot.muscles.domain.CouponDto;
import com.kinaboot.muscles.domain.PointDto;
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
    public List<UserDto> getAllUser() {
        return userDao.selectAllUser();
    }

    @Override
    public int modifyUserInfo(UserDto userDto) {
        return userDao.updateUser(userDto);
    }

    @Override
    public int createQuit(String userId) {
        return userDao.insertQuit(userId);
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
    public int modifyUserCouponStatus(String userId, String couponName) {
        return userDao.updateUserCouponStatus(userId, couponName);
    }

    @Override
    public int modifyUserPoint(String userId, int point, int orderNo) {
        return userDao.updateUserPoint(userId, point, orderNo);
    }

    @Override
    public List<CouponDto> getCoupon(String userId) {
        return userDao.selectUserCoupon(userId);
    }

    @Override
    public List<PointDto> getPointList(String userId) {
        return userDao.selectUserPoint(userId);
    }

    @Override
    public int registerRecommendEventCoupon(String userId, String recommendId) {
        return userDao.insertRecommendEventCoupon(userId, recommendId);
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
    public int removeUser(String userId) throws Exception {
        return userDao.deleteUser(userId);
    }

}
