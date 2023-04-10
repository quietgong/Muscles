package com.kinaboot.muscles.service;

import com.kinaboot.muscles.dao.UserDao;
import com.kinaboot.muscles.domain.CouponDto;
import com.kinaboot.muscles.domain.PointDto;
import com.kinaboot.muscles.domain.UserDto;
import org.apache.catalina.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    UserDao userDao;

    @Override
    public List<UserDto> findAllUser() {
        return userDao.selectAllUser();
    }

    @Override
    public int modifyUser(UserDto userDto) {
        return userDao.updateUser(userDto);
    }
    @Override
    public int removeUser(Integer userNo, HttpServletRequest request, String removeType) {
        int[] typeValue = new int[]{0, 0, 0};
        String[] type = request.getParameterValues("type");
        String opinion = request.getParameter("opinion");
        for (String s : type)
            typeValue[Integer.parseInt(s) - 1]++;
        HashMap map = new HashMap<>();
        map.put("userNo", userNo);
        map.put("type1", typeValue[0]);
        map.put("type2", typeValue[1]);
        map.put("type3", typeValue[2]);
        map.put("opinion", removeType.equals("admin") ? "관리자 탈퇴 처리" : opinion);

        userDao.insertExit(map);
        return userDao.deleteUser(userNo);
    }

    @Override
    public UserDto findUser(String userId) {
        return userDao.selectUser(userId);
    }

    @Override
    public int addUser(UserDto userDto) throws Exception {
        return userDao.insertUser(userDto);
    }

    @Override
    public int modifyCoupon(String userId, String couponName, String orderNo) {
        return userDao.updateUserCouponStatus(userId, couponName, orderNo);
    }

    @Override
    public int modifyPoint(String userId, int point, String orderNo) {
        return userDao.updateUserPoint(userId, point, orderNo);
    }

    @Override
    public List<CouponDto> findCoupons(String userId) {
        return userDao.selectUserCoupon(userId);
    }


    @Override
    public List<PointDto> findPoints(String userId) {
        return userDao.selectUserPoint(userId);
    }

    @Override
    public int addCoupon(String userId, String recommendId) {
        return userDao.insertRecommendEventCoupon(userId, recommendId);
    }
}
