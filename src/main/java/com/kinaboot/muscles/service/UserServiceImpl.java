package com.kinaboot.muscles.service;

import com.kinaboot.muscles.dao.UserDao;
import com.kinaboot.muscles.domain.CouponDto;
import com.kinaboot.muscles.domain.ExitDto;
import com.kinaboot.muscles.domain.PointDto;
import com.kinaboot.muscles.domain.UserDto;
import com.kinaboot.muscles.handler.SearchCondition;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class UserServiceImpl implements UserService {
    private final UserDao userDao;
    private final PostSerivce postSerivce;
    private final CommentService commentService;
    private final BCryptPasswordEncoder passwordEncoder;
    @Autowired
    public UserServiceImpl(UserDao userDao, PostSerivce postSerivce, CommentService commentService, BCryptPasswordEncoder passwordEncoder) {
        this.userDao = userDao;
        this.postSerivce = postSerivce;
        this.commentService = commentService;
        this.passwordEncoder = passwordEncoder;
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
    public List<UserDto> findAllUser(SearchCondition sc) {
        sc.setTotalCnt(userDao.selectAllUserCnt(sc));
        return userDao.selectAllUser(sc);
    }

    @Override
    public UserDto findUserEmail(String email) {
        return userDao.selectUserEmail(email);
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
    public PointDto findPoint(Integer orderNo) {
        return userDao.selectUserOrderPoint(orderNo);
    }

    @Override
    public int modifyUser(UserDto newUserDto) {
        UserDto oldUserDto = userDao.selectUser(newUserDto.getUserId());
        if(newUserDto.getPassword()==null)
            newUserDto.setPassword(oldUserDto.getPassword());
        else{
            String encryptedPassword = passwordEncoder.encode(newUserDto.getPassword());
            newUserDto.setPassword(encryptedPassword);
        }
        newUserDto.setPhone(newUserDto.getPhone() != null ? newUserDto.getPhone() : oldUserDto.getPhone());
        newUserDto.setEmail(newUserDto.getEmail() != null ? newUserDto.getEmail() : oldUserDto.getEmail());
        newUserDto.setAddress1(newUserDto.getAddress1() != null ? newUserDto.getAddress1() : oldUserDto.getAddress1());
        newUserDto.setAddress2(newUserDto.getAddress2() != null ? newUserDto.getAddress2() : oldUserDto.getAddress2());
        return userDao.updateUser(newUserDto);
    }

    @Override
    public int resetPassword(String userId, String resetPassword) {
        return userDao.updateUserPassword(userId, resetPassword);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
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
    public int removeCoupon(Integer couponNo, Integer orderNo) {
        return userDao.deleteCoupon(couponNo, orderNo);
    }

    @Override
    public int addUser(UserDto userDto) {
        return userDao.insertUser(userDto);
    }

    @Override
    public int modifyPoint(String userId, Integer point, Integer orderNo) {
        return userDao.updateUserPoint(userId, point, orderNo);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
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
