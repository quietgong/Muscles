package com.kinaboot.muscles.service;

import com.kinaboot.muscles.dao.UserDao;
import com.kinaboot.muscles.domain.CouponDto;
import com.kinaboot.muscles.domain.PointDto;
import com.kinaboot.muscles.domain.UserDto;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
    public int createQuit(Integer userNo) {
        return userDao.insertQuit(userNo);
    }

    @Override
    public int leaveUser(Integer userNo) {
        userDao.insertLeave(userNo);
        return userDao.deleteUser(userNo);
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
    public int modifyUserCouponStatus(String userId, String couponName, String orderNo) {
        return userDao.updateUserCouponStatus(userId, couponName, orderNo);
    }

    @Override
    public int modifyUserPoint(String userId, int point, String orderNo) {
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
    public int removeUser(Integer userNo) throws Exception {
        // 1. 유저 expiredDate 생성
        userDao.insertQuit(userNo);
        // 2. 회원탈퇴 데이터에 운영자에 의한 탈퇴임을 기록
        return userDao.deleteUser(userNo);
    }

}
