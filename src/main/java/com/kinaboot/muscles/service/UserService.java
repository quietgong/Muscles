package com.kinaboot.muscles.service;

import com.kinaboot.muscles.domain.CouponDto;
import com.kinaboot.muscles.domain.PointDto;
import com.kinaboot.muscles.domain.PostDto;
import com.kinaboot.muscles.domain.UserDto;

import java.util.List;
import java.util.Map;

public interface UserService {
    List<UserDto> getList(Integer offset, Integer pageSize) throws Exception;

    UserDto read(String userId) throws Exception;

    int create(UserDto userDto) throws Exception;

    int modify(UserDto userDto) throws Exception;

    int removeUser(Integer userNo) throws Exception;

    int modifyUserInfo(UserDto userDto);
    int modifyUserPassword(String userId, String newPassword);
    int leaveUser(Integer userNo);
    List<UserDto> getAllUser();

    int createQuit(Integer userNo);

    int registerRecommendEventCoupon(String userId, String recommendId);

    List<CouponDto> getCoupon(String userId);

    List<PointDto> getPointList(String userId);

    int modifyUserCouponStatus(String userId, String couponName, String orderNo);

    int modifyUserPoint(String userId, int point, String orderNo);
}
