package com.kinaboot.muscles.service;

import com.kinaboot.muscles.dao.UserDao;
import com.kinaboot.muscles.domain.CouponDto;
import com.kinaboot.muscles.domain.ExitDto;
import com.kinaboot.muscles.domain.PointDto;
import com.kinaboot.muscles.domain.UserDto;
import org.apache.catalina.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
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
    @Autowired
    BCryptPasswordEncoder passwordEncoder;
    @Override
    public List<UserDto> findAllUser() {
        return userDao.selectAllUser();
    }

    @Override
    public int modifyUser(UserDto userDto) {
        if(!userDto.getPassword().equals("")){
            String encryptedPassword = passwordEncoder.encode(userDto.getPassword());
            userDto.setPassword(encryptedPassword);
        }
        else
            userDto.setPassword(userDao.selectUser(userDto.getUserId()).getPassword());
        return userDao.updateUser(userDto);
    }

    @Override
    public int resetPassword(String userId, String resetPassword) {
        return userDao.updateUserPassword(userId, resetPassword);
    }

    @Override
    public UserDto findUserEmail(String email) {
        return userDao.selectUserEmail(email);
    }

    @Override
    public int removeUser(ExitDto exitDto, String removeType) throws Exception {
        String userId = exitDto.getUserId();
        if(removeType.equals("admin"))
            exitDto.setOpinion("관리자 탈퇴 처리");

        // 탈퇴유저 사용기록 삭제
        postSerivce.removePost(userId); // 게시물 삭제
        commentService.removeComment(userId); // 댓글 삭제
        userDao.deleteUserCoupon(userId); // 쿠폰 삭제

        // 탈퇴 기록 저장
        userDao.insertExit(exitDto);

        // user ExpiredDate 변경, 포인트 초기화
        return userDao.deleteUser(userDao.selectUser(userId).getUserNo());
    }

    @Override
    public int countUser(String userId) {
        return userDao.countUser(userId);
    }

    @Override
    public int removeCoupon(String userId) {
        return userDao.deleteUserCoupon(userId);
    }

    @Override
    public int removeCoupon(int couponNo, int orderNo) {
        return userDao.deleteCoupon(couponNo, orderNo);
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
    public PointDto findPoint(int orderNo) {
        return userDao.selectUserOrderPoint(orderNo);
    }


    @Override
    public int addCoupon(String userId, String recommendId) {
        int userCnt =userDao.countUser(recommendId);
        int eventPoint = 1000; // 추천받은 유저에게 보상하는 포인트
        if(userCnt!=0) {
            userDao.updateUserPoint(recommendId, eventPoint, 0);
            return userDao.insertRecommendEventCoupon(userId, recommendId);
        }
        else
            return 0;
    }
}
