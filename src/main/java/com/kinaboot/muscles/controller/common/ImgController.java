package com.kinaboot.muscles.controller.common;

import com.kinaboot.muscles.domain.GoodsImgDto;
import com.kinaboot.muscles.domain.ImgDto;
import com.kinaboot.muscles.service.GoodsService;
import com.kinaboot.muscles.service.PostSerivce;
import com.kinaboot.muscles.service.ReviewService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/img")
public class ImgController {
    @Autowired
    GoodsService goodsService;

    @Autowired
    ReviewService reviewService;

    @Autowired
    PostSerivce postSerivce;

    private static final Logger logger = LoggerFactory.getLogger(ImgController.class);

    String fileRoot = "C:\\Muscles\\src\\main\\webapp\\resources\\img\\";

    @PostMapping(value = "/{category}/{type}/{no}", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    public ResponseEntity<List<ImgDto>> imgAdd(MultipartFile[] uploadFile, @PathVariable String category, @PathVariable String type, @PathVariable Integer no) {
        logger.info("이미지 데이터 생성");
        // 서버 단 이미지 파일 체크 구현 필요
        List<ImgDto> imgDtoList = new ArrayList<>();
        String uploadPath = this.fileRoot + category + "\\" + type;
        for (MultipartFile file : uploadFile) {
            String uuid = UUID.randomUUID().toString();
            String uploadName = uuid + "_" + file.getOriginalFilename();
            File saveFile = new File(uploadPath, uploadName);
            try {
                file.transferTo(saveFile);
            } catch (IOException e) {
                e.printStackTrace();
            }
            ImgDto imgDto = new ImgDto(no, uploadPath, uploadName);
            imgDtoList.add(imgDto);
        }
        return new ResponseEntity<>(imgDtoList, HttpStatus.OK);
    }

    @GetMapping("/display")
    public ResponseEntity<byte[]> goodsImgDetails(String category, String type, String fileName) throws IOException {
        String path = this.fileRoot + category + "\\" + type + "\\";
        File file = new File(path + fileName);
        HttpHeaders header = new HttpHeaders();
        header.add("Content-type", Files.probeContentType(file.toPath()));
        return new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
    }

    @DeleteMapping("/delete/{category}/{type}")
    public ResponseEntity<String> imgRemove(@PathVariable String category, @PathVariable String type, String fileName) {
        logger.info("category=[" + category + " type=[" + type + "]" + "fileName=[" + fileName + "] 이미지 삭제");
        // 이미지 파일 삭제
        String filePath = this.fileRoot + category + "\\" + type + "\\" + fileName;
        new File(filePath).delete();

        // DB 삭제
        String imgPath = "/muscles/" + category + "/display?type=" + type + "&fileName=" + fileName;

        if (category.equals("goods"))
            goodsService.removeGoodsImg(type, imgPath);
        else if(category.equals("review"))
            reviewService.removeReviewImg(imgPath);
        return new ResponseEntity<>("DEL_OK", HttpStatus.OK);
    }
}
