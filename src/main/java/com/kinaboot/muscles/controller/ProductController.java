package com.kinaboot.muscles.controller;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kinaboot.muscles.dao.ProductDao;
import com.kinaboot.muscles.domain.*;
import com.kinaboot.muscles.service.ProductService;
import com.kinaboot.muscles.service.ReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.*;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.List;

@Controller
public class ProductController {
    @Autowired
    ProductService productService;

    @Autowired
    ReviewService reviewService;

    @GetMapping("product/display")
    public ResponseEntity<byte[]> getImage(String type, String fileName) throws IOException {
        String path = "C:\\Muscles\\src\\main\\webapp\\resources\\uploadImg\\productImg\\" + type + "\\";
        File file = new File(path + fileName);
        HttpHeaders header = new HttpHeaders();
        header.add("Content-type", Files.probeContentType(file.toPath()));
        return new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
    }

    @GetMapping("product/faq/{productNo}")
    @ResponseBody
    public ResponseEntity<List<FaqDto>> getFaq(@PathVariable Integer productNo){
        List<FaqDto> faqDtoList = productService.getFaqList(productNo);
        return new ResponseEntity<>(faqDtoList, HttpStatus.OK);
    }
    @PostMapping("product/faq/")
    @ResponseBody
    public ResponseEntity<String> registerFaq(@RequestBody FaqDto faqDto){
        productService.registerFaq(faqDto);
        return new ResponseEntity<>("ADD_OK", HttpStatus.OK);
    }


    @GetMapping("product/list")
    public String productList(SearchCondition sc, Model m){
        int totalCnt = productService.getTotalCntByCategory(sc);
        List<ProductDto> productDtoList = calculateReviewScore(productService.productList(sc));
        PageHandler ph = new PageHandler(totalCnt, sc);
        m.addAttribute("list",productDtoList);
        m.addAttribute("ph",ph);
        m.addAttribute("totalCnt", totalCnt);
        return "product/list";
    }

    public List<ProductDto> calculateReviewScore(List<ProductDto> productDtoList) {
        for(ProductDto productDto : productDtoList){
            List<ReviewDto> reviewDtoList = reviewService.getReviewListByProductNo(productDto.getProductNo());
            double productScore=0.0;
            for(ReviewDto reviewDto : reviewDtoList)
                productScore += reviewDto.getScore();
            productScore = productScore / reviewDtoList.size();
            productDto.setProductReviewScore(productScore);
            productDto.setReviewDtoList(reviewDtoList);
        }
        return productDtoList;
    }

    @GetMapping("product/detail")
    public String productDetail(Integer productNo, Model m){
        ProductDto productDto = productService.getProductByNo(productNo);
        List<ReviewDto> reviewDtoList = reviewService.getReviewListByProductNo(productNo);
        double productScore=0.0;
        for(ReviewDto reviewDto : reviewDtoList)
            productScore += reviewDto.getScore();
        productScore = productScore / reviewDtoList.size();
        m.addAttribute(productDto);
        m.addAttribute("productScore", productScore);
        m.addAttribute(reviewDtoList);
        return "product/detail";
    }
    // ????????????
    @PostMapping("/product/order")
    public String productOrder(String jsonData, Model m) throws JsonProcessingException {
        List<OrderItemDto> orderItemDtoList = new ArrayList<>();
        orderItemDtoList.add(JsonToJava(jsonData));
        m.addAttribute("list", orderItemDtoList);
        return "order/page";
    }
    public OrderItemDto JsonToJava(String jsonData) throws JsonProcessingException {
        ObjectMapper objectMapper = new ObjectMapper();
        return objectMapper.readValue(jsonData, new TypeReference<OrderItemDto>() {
        });
    }
}
