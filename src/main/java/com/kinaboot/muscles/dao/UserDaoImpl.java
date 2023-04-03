package com.kinaboot.muscles.dao;

import com.kinaboot.muscles.domain.CouponDto;
import com.kinaboot.muscles.domain.PointDto;
import com.kinaboot.muscles.domain.UserDto;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class UserDaoImpl implements UserDao {
    @Autowired
    private SqlSession session;

    @Override
    public List<UserDto> selectAllUser() {
        return session.selectList(namespace + "selectAllUser");
    }

    private static String namespace = "com.kinaboot.muscles.dao.userMapper.";

    @Override
    public int updateUserPassword(String userId, String newPassword) {
        Map map = new HashMap();
        map.put("userId", userId);
        map.put("newPassword", newPassword);
        return session.update(namespace + "updateUserPassword", map);
    }

    @Override
    public int insertLeave(Map map) {
        return session.insert(namespace + "insertLeave", map);
    }

    @Override
    public int insertQuit(String userId) {
        HashMap<String, String> map = new HashMap<>();
        map.put("userId", userId);
        map.put("opinion", "운영자에 의한 탈퇴처리");
        return session.insert(namespace + "insertQuitByAdmin", map);
    }

    @Override
    public int updateUser(UserDto userDto) {
        return session.update(namespace + "updateUser", userDto);
    }

    @Override
    public int deleteUser(String userId) {
        return session.delete(namespace + "deleteUser", userId);
    }

    @Override
    public int deleteAll() {
        return session.delete(namespace + "deleteAllUser");
    }

    @Override
    public int count() {
        return session.selectOne(namespace + "count");
    }

    @Override
    public UserDto selectUser(String id) {
        return session.selectOne(namespace + "selectUser", id);
    }

    @Override
    public List<CouponDto> selectUserCoupon(String userId) {
        return session.selectList(namespace + "selectUserCoupon", userId);
    }

    @Override
    public List<PointDto> selectUserPoint(String userId) {
        return session.selectList(namespace + "selectUserPoint", userId);
    }

    @Override
    public int updateUserCouponStatus(String userId, String couponName, String orderNo) {
        HashMap<String, String> map = new HashMap<>();
        map.put("userId", userId);
        map.put("couponName", couponName);
        map.put("orderNo", orderNo);
        return session.update(namespace + "updateCouponStatus", map);
    }

    @Override
    public int updateUserGetPoint(String userId, int point, Integer orderNo){
        HashMap<String, String> map = new HashMap<>();
        map.put("userId", userId);
        map.put("orderNo", String.valueOf(orderNo));
        map.put("point", String.valueOf(point));
        session.update(namespace + "updateUserPoint", map);
        // 포인트 적립 내역 추가
        session.insert(namespace + "insertPoint", map);
        return 0;
    }

    @Override
    public int deleteUserPoint(String userId, String pointName) {
        HashMap<String, String> map = new HashMap<>();
        map.put("userId", userId);
        map.put("pointName", pointName);
        return session.delete(namespace + "deleteUserPoint", map);
    }

    @Override
    public int updateUserPoint(String userId, int point, String orderNo) {
        HashMap<String, String> map = new HashMap<>();
        map.put("userId", userId);
        map.put("orderNo", orderNo);
        // 포인트 차감
        map.put("point", String.valueOf(-point));
        session.update(namespace + "updateUserPoint", map);
        // 포인트 사용내역 추가
        session.insert(namespace + "insertPoint", map);
        return 0;
    }



    @Override
    public int insertRecommendEventCoupon(String userId, String recommendId) {
        HashMap<String, String> map = new HashMap<>();
        map.put("userId", userId);
        map.put("recommendId", recommendId);
        map.put("point", String.valueOf(100));
        session.insert(namespace + "insertRecommendPoint", map);
        session.insert(namespace + "insertRecommendEventCoupon", map);
        map.put("userId", recommendId);
        return session.update(namespace + "updateUserPoint", map);
    }

    @Override
    public int insertUser(UserDto userDto) {
        System.out.println("userDto = " + userDto);
        return session.insert(namespace + "insertUser", userDto);
    }
}
