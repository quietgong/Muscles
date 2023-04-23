//package com.kinaboot.muscles.service;
//
//import com.kinaboot.muscles.TestConfigure;
//import com.kinaboot.muscles.dao.UserDao;
//import com.kinaboot.muscles.domain.CouponDto;
//import com.kinaboot.muscles.domain.ExitDto;
//import com.kinaboot.muscles.domain.PointDto;
//import com.kinaboot.muscles.domain.UserDto;
//import org.junit.After;
//import org.junit.Before;
//import org.junit.Test;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
//import org.springframework.stereotype.Service;
//import org.springframework.transaction.annotation.Transactional;
//
//import java.util.List;
//
//import static org.junit.Assert.*;
//
//public class UserServiceImplTest extends TestConfigure {
//    @Autowired
//    UserDao userDao;
//    @Autowired
//    PostSerivce postSerivce;
//    @Autowired
//    CommentService commentService;
//    @Autowired
//    BCryptPasswordEncoder passwordEncoder;
//
//    @Before
//    public void setUp() throws Exception {
//    }
//
//    @After
//    public void tearDown() throws Exception {
//    }
//
//    @Test
//    public int countUser(String userId) {
//        userDao.countUser(userId);
//    }
//
//    @Test
//    public UserDto findUser(String userId) {
//        userDao.selectUser(userId);
//    }
//
//    @Test
//    public List<UserDto> findAllUser() {
//        userDao.selectAllUser();
//    }
//
//    @Test
//    public UserDto findUserEmail(String email) {
//        userDao.selectUserEmail(email);
//    }
//
//    @Test
//    public List<CouponDto> findCoupons(String userId) {
//        userDao.selectUserCoupon(userId);
//    }
//
//    @Test
//    public List<PointDto> findPoints(String userId) {
//        userDao.selectUserPoint(userId);
//    }
//
//    @Test
//    public PointDto findPoint(int orderNo) {
//        userDao.selectUserOrderPoint(orderNo);
//    }
//
//    @Test
//    public int modifyUser(UserDto userDto) {
//        if (!userDto.getPassword().equals("")) {
//            String encryptedPassword = passwordEncoder.encode(userDto.getPassword());
//            userDto.setPassword(encryptedPassword);
//        } else
//            userDto.setPassword(userDao.selectUser(userDto.getUserId()).getPassword());
//        userDao.updateUser(userDto);
//    }
//
//    @Test
//    public int resetPassword(String userId, String resetPassword) {
//        userDao.updateUserPassword(userId, resetPassword);
//    }
//
//    @Test
//    public int removeUser(ExitDto exitDto, String removeType) throws Exception {
//        String userId = exitDto.getUserId();
//        if (removeType.equals("admin"))
//            exitDto.setOpinion("관리자 탈퇴 처리");
//
//        // 탈퇴유저 사용기록 삭제
//        postSerivce.removePost(userId); // 게시물 삭제
//        commentService.removeComment(userId); // 댓글 삭제
//        userDao.deleteUserCoupon(userId); // 쿠폰 삭제
//
//        // 탈퇴 기록 저장
//        userDao.insertExit(exitDto);
//
//        // user ExpiredDate 변경, 포인트 초기화
//        userDao.deleteUser(userDao.selectUser(userId).getUserNo());
//    }
//
//    @Test
//    public int removeCoupon(String userId) {
//        userDao.deleteUserCoupon(userId);
//    }
//
//    @Test
//    public int removeCoupon(int couponNo, int orderNo) {
//        userDao.deleteCoupon(couponNo, orderNo);
//    }
//
//    @Test
//    public int addUser(UserDto userDto) {
//        userDao.insertUser(userDto);
//    }
//
//    @Test
//    public int modifyPoint(String userId, int point, int orderNo) {
//        userDao.updateUserPoint(userId, point, orderNo);
//    }
//
//    @Test
//    public int addCoupon(String userId, String recommendId) {
//        int userCnt = userDao.countUser(recommendId);
//        int eventPoint = 1000; // 추천받은 유저에게 보상하는 포인트
//        if (userCnt != 0) {
//            userDao.updateUserPoint(recommendId, eventPoint, 0);
//            userDao.insertRecommendEventCoupon(userId, recommendId);
//        }
//    }
//}
