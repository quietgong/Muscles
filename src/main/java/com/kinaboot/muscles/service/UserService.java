package com.kinaboot.muscles.service;

import com.kinaboot.muscles.domain.CouponDto;
import com.kinaboot.muscles.domain.PointDto;
import com.kinaboot.muscles.domain.PostDto;
import com.kinaboot.muscles.domain.UserDto;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

public interface UserService {
    List<UserDto> findAllUser();
    UserDto findUser(String userId) throws Exception;
    int addUser(UserDto userDto) throws Exception;
    int modifyUser(UserDto userDto) throws Exception;
    int removeUser(Integer userNo, HttpServletRequest request, String removeType) throws Exception;
    List<CouponDto> findCoupons(String userId);
    int addCoupon(String userId, String recommendId);
    int modifyCoupon(String userId, String couponName, String orderNo);
    List<PointDto> findPoints(String userId);
    int modifyPoint(String userId, int point, String orderNo);
}
