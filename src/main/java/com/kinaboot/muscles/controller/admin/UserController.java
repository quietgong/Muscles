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

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@RestController
@RequestMapping("/admin/user/")
public class UserController {
    private final UserService userService;
    public UserController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("find")
    public ResponseEntity<Map<String,Object>> userList(SearchCondition sc) {
        log.info("유저 전체 목록 조회");
        Map<String, Object> map = new HashMap<>();
        map.put("user", userService.findAllUser(sc));
        map.put("totalCnt", sc.getTotalCnt());
        return new ResponseEntity<>(map, HttpStatus.OK);
    }
    @DeleteMapping("")
    public ResponseEntity<String> userRemove(@RequestBody ExitDto exitDto) {
        log.info("유저 탈퇴 처리");
        try {
            userService.removeUser(exitDto, "admin");
            log.info("[id] : " + exitDto.getUserId() + " 탈퇴 처리 성공");
            return new ResponseEntity<>("DEL_OK", HttpStatus.OK);
        } catch (Exception e) {
            log.info("[id] : " + exitDto.getUserId() + " 탈퇴 처리 실패");
            return new ResponseEntity<>("DEL_FAIL", HttpStatus.BAD_REQUEST);
        }
    }
}
