package com.kinaboot.muscles.controller.admin;

import com.kinaboot.muscles.domain.ExitDto;
import com.kinaboot.muscles.domain.UserDto;
import com.kinaboot.muscles.handler.SearchCondition;
import com.kinaboot.muscles.service.UserService;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.parameters.P;
import org.springframework.web.bind.annotation.*;

import java.util.List;
@Slf4j
@RestController
@RequestMapping("/admin/user/")
public class UserController {
    @Autowired
    UserService userService;

    @GetMapping("find")
    public ResponseEntity<List<UserDto>> userList(SearchCondition sc) {
        System.out.println("sc = " + sc);
        log.info("유저 전체 목록 조회");
        return new ResponseEntity<>(userService.findAllUser(sc), HttpStatus.OK);
    }
    @DeleteMapping("{userId}")
    public ResponseEntity<String> userRemove(@PathVariable String userId) {
        log.info("유저 탈퇴 처리");
        try {
            ExitDto exitDto = new ExitDto();
            exitDto.setUserId(userId);
            userService.removeUser(exitDto, "admin");
            log.info("[id] : " + userId + " 탈퇴 처리 성공");
            return new ResponseEntity<>("DEL_OK", HttpStatus.OK);
        } catch (Exception e) {
            log.info("[id] : " + userId + " 탈퇴 처리 실패");
            return new ResponseEntity<>("DEL_FAIL", HttpStatus.BAD_REQUEST);
        }
    }
}
