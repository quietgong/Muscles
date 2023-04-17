package com.kinaboot.muscles.service;

import com.kinaboot.muscles.TestConfigure;
import com.kinaboot.muscles.dao.UserDao;
import com.kinaboot.muscles.domain.UserDto;
import com.kinaboot.muscles.handler.SearchCondition;
import org.apache.catalina.User;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.net.URLEncoder;
import java.util.HashMap;

public class UserServiceImplTest extends TestConfigure {
    @Autowired
    UserService userService;
    @Autowired
    PostSerivce postSerivce;
    @Autowired
    CommentService commentService;
    @Autowired
    UserDao userDao;

    @Autowired
    BCryptPasswordEncoder passwordEncoder;
    @Test
    public void adminUserOutTest() throws Exception {
        int userCnt = userDao.selectAllUser().size();
        userService.removeUser("test1", null, "admin");
    }

    @Test
    public void findUserEmail() throws Exception{
        String email = "test7@test.com";
        UserDto userDto = userService.findUserEmail(email);
    }
    @Test
    public void removeUser() throws Exception {
        String userId = "test19";
        String removeType = "admin";
        int[] typeValue = new int[]{1, 0, 1};
        String opinion = "관리자에 의한 탈퇴";
        HashMap<String, String> map = new HashMap<>();
        map.put("userId", userId);
        map.put("type1", String.valueOf(typeValue[0]));
        map.put("type2", String.valueOf(typeValue[1]));
        map.put("type3", String.valueOf(typeValue[2]));
        map.put("opinion", removeType.equals("admin") ? "관리자 탈퇴 처리" : opinion);

        // 탈퇴유저 사용기록 삭제
        postSerivce.removePost(userId); // 게시물 삭제
        commentService.removeComment(userId); // 댓글 삭제
        userService.removeCoupon(userId); // 쿠폰 삭제

        // 탈퇴 기록 저장
        userDao.insertExit(map);

        // user ExpiredDate 변경, 포인트 초기화
        userDao.deleteUser(userDao.selectUser(userId).getUserNo());
    }

    @Test
    public void getUserPosts() throws Exception {
        String userId = "admin";
        postSerivce.findPosts(userId);
    }

    @Test
    public void modifyUserTest() throws Exception{
        String userId = "test10";
        UserDto originUserDto = userService.findUser(userId);
        UserDto newUserDto = userService.findUser(userId);

        String originPassword = userService.findUser(userId).getPassword();

        userService.modifyUser(originUserDto);
    }

}
