package com.kinaboot.muscles.dao;

import com.kinaboot.muscles.domain.CouponDto;
import com.kinaboot.muscles.domain.ExitDto;
import com.kinaboot.muscles.domain.PointDto;
import com.kinaboot.muscles.domain.UserDto;
import org.apache.catalina.User;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface UserDao {
    int count();

    List<UserDto> selectAllUser();

    UserDto selectUser(String userId);

    UserDto selectUserEmail(String email);

    List<PointDto> selectUserPoint(String userId);

    List<CouponDto> selectUserCoupon(String userId);

    int insertUser(UserDto userDto);

    int insertRecommendEventCoupon(String userId, String recommendId);

    int insertExit(ExitDto exitDto);

    int updateUserPoint(String userId, int point, int orderNo);

    int updateUser(UserDto userDto);

    int updateUserPassword(String userId, String newPassword);

    int deleteAll();

    int deleteUser(Integer userNo);

    int deleteUserCoupon(String userId);

    int deleteUserPoint(int orderNo);

    int countUser(String userId);

    int deleteCoupon(int couponNo, int orderNo);

    PointDto selectUserOrderPoint(int orderNo);

    int updateCoupon(int orderNo);
}
