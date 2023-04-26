package com.kinaboot.muscles.service;

import com.kinaboot.muscles.domain.*;
import com.kinaboot.muscles.handler.SearchCondition;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

public interface UserService {
    List<UserDto> findAllUser(SearchCondition sc);

    UserDto findUser(String userId) throws Exception;

    UserDto findUserEmail(String email);

    int addUser(UserDto userDto) throws Exception;

    int modifyUser(UserDto userDto) throws Exception;

    int removeUser(ExitDto exitDto, String removeType) throws Exception;

    List<CouponDto> findCoupons(String userId);

    int addCoupon(String userId, String recommendId);

    List<PointDto> findPoints(String userId);

    PointDto findPoint(Integer orderNo);

    int modifyPoint(String userId, Integer point, Integer orderNo);

    int countUser(String userId);

    int removeCoupon(Integer couponNo, Integer orderNo);

    int resetPassword(String userId, String resetPassword);

}
