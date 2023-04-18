package com.kinaboot.muscles.controller;

import com.kinaboot.muscles.domain.*;
import com.kinaboot.muscles.handler.PageHandler;
import com.kinaboot.muscles.handler.SearchCondition;
import com.kinaboot.muscles.service.GoodsService;
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
@RequestMapping("/goods")
public class GoodsController {
    private static final Logger logger = LoggerFactory.getLogger(GoodsController.class);

    @Autowired
    GoodsService goodsService;

    @Autowired
    ReviewService reviewService;

    @GetMapping("/best")
    @ResponseBody
    public ResponseEntity<List<GoodsDto>> bestGoodsList() {
        logger.info("베스트 상품");
        return new ResponseEntity<>(goodsService.findBestGoods(), HttpStatus.OK);
    }

    @GetMapping("/{goodsNo}")
    @ResponseBody
    public ResponseEntity<GoodsDto> goodsDetails(@PathVariable Integer goodsNo) {
        return new ResponseEntity<>(goodsService.findGoods(goodsNo), HttpStatus.OK);
    }

    @GetMapping("/faq/{goodsNo}")
    @ResponseBody
    public ResponseEntity<List<FaqDto>> faqList(@PathVariable Integer goodsNo) {
        logger.info("[goodsNo] : " + goodsNo + " 문의 리스트 출력");
        List<FaqDto> faqDtoList = goodsService.findFaqs(goodsNo);
        return new ResponseEntity<>(faqDtoList, HttpStatus.OK);
    }

    @PostMapping("/faq/")
    @ResponseBody
    public ResponseEntity<String> faqAdd(@RequestBody FaqDto faqDto) {
        goodsService.addFaq(faqDto);
        return new ResponseEntity<>("ADD_OK", HttpStatus.OK);
    }

    @GetMapping("/category")
    @ResponseBody
    public ResponseEntity<List<GoodsCategoryDto>> categoriesList() {
        return new ResponseEntity<>(goodsService.findAllCategories(), HttpStatus.OK);
    }

    @GetMapping("/list")
    public String goodsList(SearchCondition sc, Model m) {
        logger.info("상품 목록 진입");
        int totalCnt = goodsService.getTotalCntByCategory(sc);
        PageHandler ph = new PageHandler(totalCnt, sc);
        m.addAttribute("list", goodsService.findGoods(sc));
        m.addAttribute("ph", ph);
        return "goods/list";
    }

    @GetMapping("/detail")
    public String goodsDetails(Integer goodsNo, Model m) {
        GoodsDto goodsDto = goodsService.findGoods(goodsNo);
        List<GoodsImgDto> goodsImgDtoList = goodsService.getGoodsDetailImgList(goodsNo);

        List<ReviewDto> reviewDtoList = reviewService.findReviews(goodsNo);
        for(ReviewDto reviewDto : reviewDtoList){
            reviewDto.setReviewImgDtoList(reviewService.findReviewImg(reviewDto.getReviewNo(),goodsNo));
        }
        double goodsScore = 0.0;
        if (reviewDtoList.size() != 0) {
            for (ReviewDto reviewDto : reviewDtoList)
                goodsScore += reviewDto.getScore();
            goodsScore = goodsScore / reviewDtoList.size();
        }
        goodsDto.setGoodsReviewScore(goodsScore);
        m.addAttribute(goodsDto);
        m.addAttribute(reviewDtoList);
        m.addAttribute(goodsImgDtoList);
        return "goods/detail";
    }
}
