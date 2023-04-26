package com.kinaboot.muscles.dao;

import com.kinaboot.muscles.domain.CouponDto;
import com.kinaboot.muscles.domain.ExitDto;
import com.kinaboot.muscles.domain.PointDto;
import com.kinaboot.muscles.domain.UserDto;
import com.kinaboot.muscles.handler.SearchCondition;
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

    private static String namespace = "com.kinaboot.muscles.dao.userMapper.";

    @Override
    public int count() {
        return session.selectOne(namespace + "count");
    }

    @Override
    public UserDto selectUser(String userId) {
        return session.selectOne(namespace + "selectUser", userId);
    }

    @Override
    public int selectAllUserCnt(SearchCondition sc) {
        return session.selectOne(namespace + "selectAllUserCnt", sc);
    }

    @Override
    public List<UserDto> selectAllUser(SearchCondition sc) {
        return session.selectList(namespace + "selectAllUser", sc);
    }

    @Override
    public UserDto selectUserEmail(String email) {
        return session.selectOne(namespace + "selectUserEmail", email);
    }

    @Override
    public int countUser(String userId) {
        return session.selectOne(namespace + "countUser", userId);
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
    public PointDto selectUserOrderPoint(Integer orderNo) {
        return session.selectOne(namespace + "selectUserOrderPoint", orderNo);
    }

    @Override
    public int insertUser(UserDto userDto) {
        return session.insert(namespace + "insertUser", userDto);
    }

    @Override
    public int insertRecommendEventCoupon(String userId, String recommendId) {
        HashMap<String, String> map = new HashMap<>();
        map.put("userId", userId);
        map.put("recommendId", recommendId);
        map.put("discount", String.valueOf(10000));
        return session.insert(namespace + "insertRecommendEventCoupon", map);
    }

    @Override
    public int insertExit(ExitDto exitDto) {
        return session.insert(namespace + "insertExit", exitDto);
    }

    @Override
    public int updateUser(UserDto userDto) {
        return session.update(namespace + "updateUser", userDto);
    }

    @Override
    public int updateUserPassword(String userId, String newPassword) {
        Map<String, String> map = new HashMap<>();
        map.put("userId", userId);
        map.put("newPassword", newPassword);
        return session.update(namespace + "updateUserPassword", map);
    }

    @Override
    public int updateCoupon(Integer orderNo) {
        return session.update(namespace + "updateCoupon", orderNo);
    }

    @Override
    public int updateUserPoint(String userId, Integer point, Integer orderNo) {
        HashMap<String, String> map = new HashMap<>();
        map.put("userId", userId);
        map.put("orderNo", String.valueOf(orderNo));
        map.put("point", String.valueOf(point));

        session.update(namespace + "updateUserPoint", map);
        return session.insert(namespace + "insertPoint", map);
    }

    @Override
    public int deleteUser(Integer userNo) {
        return session.delete(namespace + "deleteUser", userNo);
    }

    @Override
    public int deleteAll() {
        return session.delete(namespace + "deleteAll");
    }

    @Override
    public int deleteUserCoupon(String userId) {
        return session.delete(namespace + "deleteUserCoupon", userId);
    }

    @Override
    public int deleteCoupon(Integer couponNo, Integer orderNo) {
        HashMap<String, Integer> map = new HashMap<>();
        map.put("couponNo", couponNo);
        map.put("orderNo", orderNo);
        return session.delete(namespace + "deleteCoupon", map);
    }

    @Override
    public int deleteUserPointHistory(Integer orderNo) {
        return session.delete(namespace + "deleteUserPointHistory", orderNo);
    }
}
