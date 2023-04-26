package com.kinaboot.muscles.dao;

import com.kinaboot.muscles.domain.CouponDto;
import com.kinaboot.muscles.domain.ExitDto;
import com.kinaboot.muscles.domain.PointDto;
import com.kinaboot.muscles.domain.UserDto;
import com.kinaboot.muscles.handler.SearchCondition;
import org.apache.catalina.User;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface UserDao {
    int count();

    List<UserDto> selectAllUser(SearchCondition sc);

    UserDto selectUser(String userId);

    UserDto selectUserEmail(String email);

    List<PointDto> selectUserPoint(String userId);

    List<CouponDto> selectUserCoupon(String userId);

    int insertUser(UserDto userDto);

    int insertRecommendEventCoupon(String userId, String recommendId);

    int insertExit(ExitDto exitDto);

    int updateUserPoint(String userId, Integer point, Integer orderNo);

    int updateUser(UserDto userDto);

    int updateUserPassword(String userId, String newPassword);

    int deleteAll();

    int deleteUser(Integer userNo);

    int deleteUserCoupon(String userId);

    int countUser(String userId);

    int deleteCoupon(Integer couponNo, Integer orderNo);

    PointDto selectUserOrderPoint(Integer orderNo);

    int updateCoupon(Integer orderNo);

    int deleteUserPointHistory(Integer orderNo);

    int selectAllUserCnt(SearchCondition sc);
}
