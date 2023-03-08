package com.kinaboot.muscles.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kinaboot.muscles.domain.OrderItemDto;
import com.kinaboot.muscles.domain.ReviewDto;
import com.kinaboot.muscles.service.ReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class ReviewController {
    @Autowired
    ReviewService reviewService;

    @PostMapping("/review")
    @ResponseBody
    // 리뷰 등록
    public ResponseEntity<String> createReview(@RequestBody String jsonData) throws JsonProcessingException {
        List<ReviewDto> reviewDtoList = JsonToJava(jsonData);
        reviewService.createReview(reviewDtoList);
        System.out.println("reviewDtoList = " + reviewDtoList);
        return new ResponseEntity<>("ADD_OK", HttpStatus.OK);
    }
    public List<ReviewDto> JsonToJava(String rowData) throws JsonProcessingException {
        ObjectMapper objectMapper = new ObjectMapper();
        return objectMapper.readValue(rowData, new TypeReference<List<ReviewDto>>() {
        });
    }
}
