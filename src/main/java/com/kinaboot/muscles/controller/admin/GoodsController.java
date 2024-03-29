package com.kinaboot.muscles.controller.admin;

import com.kinaboot.muscles.domain.GoodsDto;
import com.kinaboot.muscles.domain.GoodsImgDto;
import com.kinaboot.muscles.handler.SearchCondition;
import com.kinaboot.muscles.service.GoodsService;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.UUID;
@Slf4j
@RestController
@RequestMapping("/admin/goods/")
public class GoodsController {
    private final GoodsService goodsService;
    public GoodsController(GoodsService goodsService) {
        this.goodsService = goodsService;
    }

    @GetMapping("")
    public ResponseEntity<List<GoodsDto>> goodsList() {
        log.info("상품 목록 조회");
        return new ResponseEntity<>(goodsService.findAllGoods(), HttpStatus.OK);
    }
    @GetMapping("{goodsNo}")
    public ResponseEntity<GoodsDto> goodsDetails(@PathVariable Integer goodsNo) {
        log.info("단 건 상품 조회");
        return new ResponseEntity<>(goodsService.findGoods(goodsNo), HttpStatus.OK);
    }

    @PostMapping("")
    public ResponseEntity<String> goodsAdd(@RequestBody GoodsDto goodsDto) {
        log.info("단 건 상품 등록");
        goodsService.addGoods(goodsDto);
        return new ResponseEntity<>("ADD_OK", HttpStatus.OK);
    }

    @PatchMapping("")
    public ResponseEntity<String> goodsModify(@RequestBody GoodsDto goodsDto) {
        log.info("단 건 상품 수정");
        goodsService.modifyGoods(goodsDto);
        return new ResponseEntity<>("MOD_OK", HttpStatus.OK);
    }

    @DeleteMapping("{goodsNo}")
    public ResponseEntity<String> goodsRemove(@PathVariable Integer goodsNo) {
        log.info("단 건 상품 삭제");
        goodsService.removeGoods(goodsNo);
        return new ResponseEntity<>("DEL_OK", HttpStatus.OK);
    }
}
