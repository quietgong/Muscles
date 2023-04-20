package com.kinaboot.muscles.service;

import com.kinaboot.muscles.domain.*;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

public interface UserService {
    List<UserDto> findAllUser();
    UserDto findUser(String userId) throws Exception;
    UserDto findUserEmail(String email);
    int addUser(UserDto userDto) throws Exception;
    int modifyUser(UserDto userDto) throws Exception;
    int removeUser(ExitDto exitDto, String removeType) throws Exception;
    List<CouponDto> findCoupons(String userId);
    int addCoupon(String userId, String recommendId);
    List<PointDto> findPoints(String userId);
    PointDto findPoint(int orderNo);
    int modifyPoint(String userId, int point, int orderNo);
    int countUser(String userId);
    int removeCoupon(int couponNo, int orderNo);
    int removeCoupon(String userId);

    int resetPassword(String userId, String resetPassword);

}
