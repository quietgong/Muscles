package com.kinaboot.muscles.controller;

import com.kinaboot.muscles.domain.ReviewDto;
import com.kinaboot.muscles.service.ReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class ReviewController {
    @Autowired
    ReviewService reviewService;

    @PostMapping("/review")
    @ResponseBody
    // 리뷰 등록
    public ResponseEntity<String> createReview(@RequestBody ReviewDto reviewDto) {
        reviewService.createReview(reviewDto);
        return new ResponseEntity<>("ADD_OK", HttpStatus.OK);
    }
    @PatchMapping("/review")
    @ResponseBody
    // 리뷰 등록
    public ResponseEntity<String> modifyReview(@RequestBody ReviewDto reviewDto) {
        reviewService.modifyReview(reviewDto);
        return new ResponseEntity<>("MOD_OK", HttpStatus.OK);
    }
}
