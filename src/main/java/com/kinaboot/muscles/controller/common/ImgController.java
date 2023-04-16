package com.kinaboot.muscles.controller.common;

import com.kinaboot.muscles.domain.GoodsImgDto;
import com.kinaboot.muscles.service.GoodsService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/img")
public class ImgController {
    @Autowired
    GoodsService goodsService;

    private static final Logger logger = LoggerFactory.getLogger(ImgController.class);

    @PostMapping(value = "/{category}/{type}/{goodsNo}", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    public ResponseEntity<List<?>> imgAdd(MultipartFile[] uploadFile, @PathVariable String category, @PathVariable String type, @PathVariable Integer goodsNo) {
        logger.info("[goodsNo : " + goodsNo + "] 이미지 데이터 생성");
        // 서버 단 이미지 파일 체크 구현 필요
        List<GoodsImgDto> goodsImgDtoList = new ArrayList<>();
        String uploadPath = "C:\\Muscles\\src\\main\\webapp\\resources\\img\\" + category + "\\" + type;
        for (MultipartFile file : uploadFile) {
            String uuid = UUID.randomUUID().toString();
            String uploadName = uuid + "_" + file.getOriginalFilename();
            File saveFile = new File(uploadPath, uploadName);
            try {
                file.transferTo(saveFile);
            } catch (IOException e) {
                e.printStackTrace();
            }
            if (category.equals("goods")) {
                GoodsImgDto goodsImgDto = new GoodsImgDto(goodsNo, uploadPath, uploadName, uuid);
                goodsImgDtoList.add(goodsImgDto);
            }
        }
        return new ResponseEntity<>(goodsImgDtoList, HttpStatus.OK);
    }

    @DeleteMapping("/delete/{category}/{type}")
    public ResponseEntity<String> imgRemove(@PathVariable String category, @PathVariable String type, String fileName) {
        logger.info("category=[" + category + " type=[" + type + "]" + "fileName=[" + fileName + "] 이미지 삭제");
        // 이미지 파일 삭제
        String filePath = "C:\\Muscles\\src\\main\\webapp\\resources\\img\\" + category + "\\" + type + "\\" + fileName;
        new File(filePath).delete();
        // DB 삭제
        String imgPath = "/muscles/" + category + "/display?type=" + type + "&fileName=" + fileName;
        if (category.equals("goods"))
            goodsService.removeGoodsImg(type, imgPath);
        return new ResponseEntity<>("DEL_OK", HttpStatus.OK);
    }
}
