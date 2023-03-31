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

    int removeUser(String userId) throws Exception;

    int modifyUserInfo(UserDto userDto);
    int modifyUserPassword(String userId, String newPassword);
    int leaveUser(Map map);
    List<UserDto> getAllUser();

    int createQuit(String userId);

    int registerRecommendEventCoupon(String userId, String recommendId);

    List<CouponDto> getCoupon(String userId);

    List<PointDto> getPointList(String userId);

    int modifyUserCouponStatus(String userId, String couponName);

    int modifyUserPoint(String userId, int point, int orderNo);
}
