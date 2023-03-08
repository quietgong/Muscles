package com.kinaboot.muscles.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kinaboot.muscles.domain.OrderItemDto;
import com.kinaboot.muscles.domain.ReviewDto;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class ReviewController {
    @ResponseBody
    @PostMapping("/review")
    public ResponseEntity<String> createReview(@RequestBody String jsonData, HttpSession session) throws JsonProcessingException {
        String userId = (String) session.getAttribute("id");
        List<ReviewDto> reviewDtoList = JsonToJava(jsonData);
        System.out.println("reviewDtoList = " + reviewDtoList);
        return new ResponseEntity<>("ADD_OK", HttpStatus.OK);
    }
    public List<ReviewDto> JsonToJava(String rowData) throws JsonProcessingException {
        ObjectMapper objectMapper = new ObjectMapper();
        return objectMapper.readValue(rowData, new TypeReference<List<ReviewDto>>() {
        });
    }
}
