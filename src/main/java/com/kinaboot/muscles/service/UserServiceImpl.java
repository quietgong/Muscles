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

    @Autowired
    PostSerivce postSerivce;

    @Autowired
    CommentService commentService;
    @Override
    public List<UserDto> findAllUser() {
        return userDao.selectAllUser();
    }

    @Override
    public int modifyUser(UserDto userDto) {
        return userDao.updateUser(userDto);
    }

    @Override
    public int removeUser(String userId, HttpServletRequest request, String removeType) throws Exception {
        int[] typeValue = new int[]{0, 0, 0};
        String opinion = "";
        HashMap<String,String> map = new HashMap<>();
        map.put("userId", userId);
        if (request != null) {
            String[] type = request.getParameterValues("type");
            opinion = request.getParameter("opinion");
            for (String s : type)
                typeValue[Integer.parseInt(s) - 1]++;
            map.put("type1", String.valueOf(typeValue[0]));
            map.put("type2", String.valueOf(typeValue[1]));
            map.put("type3", String.valueOf(typeValue[2]));
        }
        map.put("opinion", removeType.equals("admin") ? "관리자 탈퇴 처리" : opinion);

        // 탈퇴유저 사용기록(게시물, 댓글, 포인트) 삭제
        userDao.removePoint(userId);
        postSerivce.removePost(userId);
        commentService.removeComment(userId);
        // 탈퇴 기록 저장
        userDao.insertExit(map);
        // user ExpiredDate 변경
        return userDao.deleteUser(userDao.selectUser(userId).getUserNo());
    }

    @Override
    public int countUser(String userId) {
        return userDao.countUser(userId);
    }

    @Override
    public UserDto findUser(String userId) {
        return userDao.selectUser(userId);
    }

    @Override
    public int addUser(UserDto userDto) {
        return userDao.insertUser(userDto);
    }

    @Override
    public int modifyCoupon(String userId, int couponNo) {
        return userDao.updateUserCouponStatus(couponNo);
    }

    @Override
    public int modifyPoint(String userId, int point, int orderNo) {
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
