package com.kinaboot.muscles.dao;

import com.kinaboot.muscles.domain.CouponDto;
import com.kinaboot.muscles.domain.PointDto;
import com.kinaboot.muscles.domain.UserDto;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

public interface UserDao {

    UserDto selectUser(String id);

    int insertUser(UserDto userDto);
    int deleteAll();

    int count();

    int updateUser(UserDto userDto);

    int deleteUser(String userId);

    int insertLeave(Map map);

    int updateUserPassword(String userId, String newPassword);

    List<UserDto> selectAllUser();

    int insertQuit(String userId);

    int insertRecommendEventCoupon(String userId, String recommendId);

    List<CouponDto> selectUserCoupon(String userId);

    List<PointDto> selectUserPoint(String userId);

    int updateUserCouponStatus(String userId, String couponName, String orderNo);

    int updateUserPoint(String userId, int point, String orderNo);

    int updateUserGetPoint(String userId, int point, Integer orderNo);

    int deleteUserPoint(String userId, String pointName);
}
