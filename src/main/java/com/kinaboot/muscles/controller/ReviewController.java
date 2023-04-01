package com.kinaboot.muscles.controller;

import com.kinaboot.muscles.domain.ReviewDto;
import com.kinaboot.muscles.service.ReviewService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class ReviewController {
    private static final Logger logger = LoggerFactory.getLogger(ReviewController.class);

    @Autowired
    ReviewService reviewService;

    @PostMapping("/review")
    @ResponseBody
    // 리뷰 등록
    public ResponseEntity<String> createReview(@RequestBody ReviewDto reviewDto) {
        logger.info("리뷰 등록 진입");

        reviewService.createReview(reviewDto);
        return new ResponseEntity<>("ADD_OK", HttpStatus.OK);
    }
    @PatchMapping("/review")
    @ResponseBody
    // 리뷰 수정
    public ResponseEntity<String> modifyReview(@RequestBody ReviewDto reviewDto) {
        logger.info("리뷰 수정 진입");

        reviewService.modifyReview(reviewDto);
        return new ResponseEntity<>("MOD_OK", HttpStatus.OK);
    }
}
