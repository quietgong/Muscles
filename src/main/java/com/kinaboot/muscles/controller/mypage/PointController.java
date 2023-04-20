package com.kinaboot.muscles.controller.mypage;

import com.kinaboot.muscles.domain.PointDto;
import com.kinaboot.muscles.service.UserService;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
@Slf4j
@Controller
@RequestMapping("/mypage/point")
public class PointController {
    @Autowired
    UserService userService;

    // 포인트 내역
    @GetMapping("/{userId}")
    @ResponseBody
    public ResponseEntity<List<PointDto>> pointList(@PathVariable String userId){
        log.info("포인트 내역 조회");
        return new ResponseEntity<>(userService.findPoints(userId), HttpStatus.OK);
    }
}
