package com.kinaboot.muscles.controller;

import com.kinaboot.muscles.domain.*;
import com.kinaboot.muscles.handler.PageHandler;
import com.kinaboot.muscles.handler.SearchCondition;
import com.kinaboot.muscles.service.ProductService;
import com.kinaboot.muscles.service.ReviewService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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
import java.util.List;

@Controller
@RequestMapping("/product")
public class ProductController {
    private static final Logger logger = LoggerFactory.getLogger(ProductController.class);

    @Autowired
    ProductService productService;

    @Autowired
    ReviewService reviewService;

    @GetMapping("/{productNo}")
    @ResponseBody
    public ResponseEntity<ProductDto> productDetails(@PathVariable Integer productNo) {
        return new ResponseEntity<>(productService.findProduct(productNo), HttpStatus.OK);
    }

    @GetMapping("/display")
    public ResponseEntity<byte[]> productImgDetails(String type, String fileName) throws IOException {
        String path = "C:\\Muscles\\src\\main\\webapp\\resources\\img\\product\\" + type + "\\";
        File file = new File(path + fileName);
        HttpHeaders header = new HttpHeaders();
        header.add("Content-type", Files.probeContentType(file.toPath()));
        return new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
    }

    @GetMapping("/faq/{productNo}")
    @ResponseBody
    public ResponseEntity<List<FaqDto>> faqList(@PathVariable Integer productNo) {
        List<FaqDto> faqDtoList = productService.findFaqs(productNo);
        return new ResponseEntity<>(faqDtoList, HttpStatus.OK);
    }

    @PostMapping("/faq/")
    @ResponseBody
    public ResponseEntity<String> faqAdd(@RequestBody FaqDto faqDto) {
        productService.addFaq(faqDto);
        return new ResponseEntity<>("ADD_OK", HttpStatus.OK);
    }


    @GetMapping("/list")
    public String productList(SearchCondition sc, Model m) {
        int totalCnt = productService.getTotalCntByCategory(sc);
        List<ProductDto> productDtoList = calculateReviewScore(productService.findProducts(sc));
        PageHandler ph = new PageHandler(totalCnt, sc);
        m.addAttribute("list", productDtoList);
        m.addAttribute("ph", ph);
        m.addAttribute("totalCnt", totalCnt);
        return "product/list";
    }

    private List<ProductDto> calculateReviewScore(List<ProductDto> productDtoList) {
        for (ProductDto productDto : productDtoList) {
            List<ReviewDto> reviewDtoList = reviewService.findReviews(productDto.getProductNo());
            double productScore = 0.0;
            if (reviewDtoList.size() != 0) {
                for (ReviewDto reviewDto : reviewDtoList)
                    productScore += reviewDto.getScore();
                productScore = productScore / reviewDtoList.size();
            }
            productDto.setProductReviewScore(productScore);
            productDto.setReviewDtoList(reviewDtoList);
        }
        return productDtoList;
    }

    @GetMapping("/detail")
    public String productDetails(Integer productNo, Model m) {
        ProductDto productDto = productService.findProduct(productNo);
        List<ReviewDto> reviewDtoList = reviewService.findReviews(productNo);
        List<ProductImgDto> productImgDtoList = productService.getProductDetailImgList(productNo);
        double productScore = 0.0;
        if(reviewDtoList.size()!=0){
            for (ReviewDto reviewDto : reviewDtoList)
                productScore += reviewDto.getScore();
            productScore = productScore / reviewDtoList.size();
        }
        productDto.setProductReviewScore(productScore);
        m.addAttribute(productDto);
        m.addAttribute(reviewDtoList);
        m.addAttribute(productImgDtoList);
        return "product/detail";
    }
}
