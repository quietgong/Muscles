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
    int removeUser(String userId, HttpServletRequest request, String removeType) throws Exception;
    List<CouponDto> findCoupons(String userId);
    int addCoupon(String userId, String recommendId);
    int modifyCoupon(String userId, int couponNo);
    List<PointDto> findPoints(String userId);
    int modifyPoint(String userId, int point, int orderNo);

    int countUser(String userId);

    int removeCoupon(String userId);
}
