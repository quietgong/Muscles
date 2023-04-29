package com.kinaboot.muscles.controller;

import com.kinaboot.muscles.domain.*;
import com.kinaboot.muscles.handler.PageHandler;
import com.kinaboot.muscles.handler.SearchCondition;
import com.kinaboot.muscles.service.GoodsService;
import com.kinaboot.muscles.service.ReviewService;
import lombok.extern.slf4j.Slf4j;
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

@Slf4j
@Controller
@RequestMapping("/goods")
public class GoodsController {

    private final GoodsService goodsService;

    @Autowired
    public GoodsController(GoodsService goodsService) {
        this.goodsService = goodsService;
    }

    @GetMapping("/best")
    @ResponseBody
    public ResponseEntity<List<GoodsDto>> bestGoodsList() {
        log.info("베스트 상품");
        return new ResponseEntity<>(goodsService.findBestGoods(), HttpStatus.OK);
    }

    @GetMapping("/{goodsNo}")
    @ResponseBody
    public ResponseEntity<GoodsDto> goodsDetails(@PathVariable Integer goodsNo) {
        log.info("[상품번호 " + goodsNo + " ] 상세 정보 조회");
        return new ResponseEntity<>(goodsService.findGoods(goodsNo), HttpStatus.OK);
    }

    @GetMapping("/faq/{goodsNo}")
    @ResponseBody
    public ResponseEntity<List<FaqDto>> faqList(@PathVariable Integer goodsNo) {
        log.info("[goodsNo] : " + goodsNo + " 문의 리스트 조회");
        List<FaqDto> faqDtoList = goodsService.findFaqs(goodsNo);
        return new ResponseEntity<>(faqDtoList, HttpStatus.OK);
    }

    @PostMapping("/faq/")
    @ResponseBody
    public ResponseEntity<String> faqAdd(@RequestBody FaqDto faqDto) {
        log.info("[goodsNo] : " + faqDto.getGoodsNo() + " 문의 등록");
        goodsService.addFaq(faqDto);
        return new ResponseEntity<>("ADD_OK", HttpStatus.OK);
    }

    @GetMapping("/category")
    @ResponseBody
    public ResponseEntity<List<GoodsCategoryDto>> categoriesList() {
        log.info("카테고리 목록 조회");
        return new ResponseEntity<>(goodsService.findAllCategories(), HttpStatus.OK);
    }

    @GetMapping("/list")
    public String goodsList(SearchCondition sc, Model m) {
        log.info("상품 목록 조회");
        int totalCnt = goodsService.getTotalCntByCategory(sc);
        PageHandler ph = new PageHandler(totalCnt, sc);
        m.addAttribute("list", goodsService.findGoods(sc));
        m.addAttribute("ph", ph);
        return "goods/list";
    }

    @GetMapping("/detail")
    public String goodsDetails(Integer goodsNo, Model m) {
        log.info("상품 상세 조회");
        m.addAttribute("goodsDto", goodsService.findGoods(goodsNo));
        return "goods/detail";
    }
}
