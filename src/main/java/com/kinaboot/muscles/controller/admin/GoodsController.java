package com.kinaboot.muscles.controller.admin;

import com.kinaboot.muscles.domain.GoodsDto;
import com.kinaboot.muscles.domain.GoodsImgDto;
import com.kinaboot.muscles.service.GoodsService;
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
import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/admin/goods/")
public class GoodsController {
    @Autowired
    GoodsService goodsService;

    private static final Logger logger = LoggerFactory.getLogger(GoodsController.class);
    @GetMapping("")
    @ResponseBody
    public ResponseEntity<List<GoodsDto>> goodsList() {
        logger.info("상품 목록 조회");
        return new ResponseEntity<>(goodsService.findAllGoods(), HttpStatus.OK);
    }
    @GetMapping("{goodsNo}")
    @ResponseBody
    public ResponseEntity<GoodsDto> goodsDetails(@PathVariable Integer goodsNo) {
        logger.info("단 건 상품 조회");
        return new ResponseEntity<>(goodsService.findGoods(goodsNo), HttpStatus.OK);
    }
    @DeleteMapping("{goodsNo}")
    @ResponseBody
    public ResponseEntity<String> goodsRemove(@PathVariable Integer goodsNo) {
        logger.info("단 건 상품 삭제");
        goodsService.removeGoods(goodsNo);
        return new ResponseEntity<>("DEL_OK", HttpStatus.OK);
    }
    @PatchMapping("")
    @ResponseBody
    public ResponseEntity<String> goodsModify(@RequestBody GoodsDto goodsDto) {
        logger.info("단 건 상품 수정");
        goodsService.modifyGoods(goodsDto);
        return new ResponseEntity<>("MOD_OK", HttpStatus.OK);
    }

    @GetMapping("detailImg/{goodsNo}")
    @ResponseBody
    public ResponseEntity<List<GoodsImgDto>> goodsImgList(@PathVariable Integer goodsNo) {
        logger.info("[goodsNo] " + goodsNo + " 상세 이미지 목록 조회");
        return new ResponseEntity<>(goodsService.getGoodsDetailImgList(goodsNo), HttpStatus.OK);
    }

    @PostMapping("file/delete")
    public ResponseEntity<String> goodsImgRemove(String type, String fileName) {
        logger.info("type=[" + type + "]" + "fileName=[" + fileName + "] 이미지 삭제");
        String uploadPath = "C:\\Muscles\\src\\main\\webapp\\resources\\uploadImg\\goods\\" + type + "\\";
        new File(uploadPath + fileName).delete();
        return new ResponseEntity<>("DEL_OK", HttpStatus.OK);
    }

    @PostMapping(value = "file/{type}/{goodsNo}", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    public ResponseEntity<List<GoodsImgDto>> goodsImgAdd(MultipartFile[] uploadFile, @PathVariable String type, @PathVariable Integer goodsNo) throws IOException {
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
}
