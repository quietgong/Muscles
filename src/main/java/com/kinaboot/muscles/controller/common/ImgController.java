package com.kinaboot.muscles.controller.common;

import com.kinaboot.muscles.controller.admin.GoodsController;
import com.kinaboot.muscles.domain.GoodsImgDto;
import com.kinaboot.muscles.service.GoodsService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/img")
public class ImgController {
    @Autowired
    GoodsService goodsService;

    private static final Logger logger = LoggerFactory.getLogger(ImgController.class);

    @PostMapping(value = "file/{type}/{goodsNo}", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    public ResponseEntity<List<GoodsImgDto>> goodsImgAdd(MultipartFile[] uploadFile, @PathVariable String type, @PathVariable Integer goodsNo) throws IOException {
        logger.info("[goodsNo] :" + goodsNo + " 이미지 데이터 생성");
        // 서버 단에서 이미지 파일 체크 구현 필요
        List<GoodsImgDto> goodsImgDtoList = new ArrayList<>();
        String uploadPath = "C:\\Muscles\\src\\main\\webapp\\resources\\img\\goods\\" + type;
        for (MultipartFile file : uploadFile) {
            String uuid = UUID.randomUUID().toString();
            String uploadName = uuid + "_" + file.getOriginalFilename();
            File saveFile = new File(uploadPath, uploadName);
            file.transferTo(saveFile);
            GoodsImgDto goodsImgDto = new GoodsImgDto(goodsNo, uploadPath, uploadName, uuid);
            goodsImgDtoList.add(goodsImgDto);
        }
        return new ResponseEntity<>(goodsImgDtoList, HttpStatus.OK);
    }

    @DeleteMapping("/delete")
    public ResponseEntity<String> goodsImgRemove(String type, String fileName) {
        logger.info("type=[" + type + "]" + "fileName=[" + fileName + "] 이미지 삭제");
        String uploadPath = "C:\\Muscles\\src\\main\\webapp\\resources\\img\\goods\\" + type + "\\";
        new File(uploadPath + fileName).delete();
        goodsService.removeGoodsImg(type, fileName);
        return new ResponseEntity<>("DEL_OK", HttpStatus.OK);
    }

}
