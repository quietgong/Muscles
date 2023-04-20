package com.kinaboot.muscles.controller;

import com.kinaboot.muscles.domain.ReviewDto;
import com.kinaboot.muscles.service.ReviewService;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
@Slf4j
@RestController
@RequestMapping("/review")
public class ReviewController {

    @Autowired
    ReviewService reviewService;

    // 리뷰 등록
    @PostMapping("")
    public ResponseEntity<String> reviewAdd(@RequestBody ReviewDto reviewDto) {
        log.info("리뷰 등록 진입");
        reviewService.addReview(reviewDto);
        return new ResponseEntity<>("ADD_OK", HttpStatus.OK);
    }
    // 리뷰 수정
    @PatchMapping("")
    public ResponseEntity<String> reviewModify(@RequestBody ReviewDto reviewDto) {
        log.info("리뷰 수정 진입");
        reviewService.modifyReview(reviewDto);
        return new ResponseEntity<>("MOD_OK", HttpStatus.OK);
    }
    // 리뷰 읽기
    @GetMapping("/{reviewNo}")
    public ResponseEntity<ReviewDto> reviewDetails(@PathVariable Integer reviewNo){
        log.info("리뷰 데이터 GET 진입");
        return new ResponseEntity<>(reviewService.findReview(reviewNo), HttpStatus.OK);
    }
    // 리뷰 삭제
    @DeleteMapping("/{reviewNo}")
    public ResponseEntity<String> reviewRemove(@PathVariable Integer reviewNo) {
        log.info("리뷰 삭제 진입");
        reviewService.removeReview(reviewNo);
        return new ResponseEntity<>("DEL_OK", HttpStatus.OK);
    }
}
