package com.kinaboot.muscles.controller.admin;

import com.kinaboot.muscles.domain.ProductDto;
import com.kinaboot.muscles.domain.ProductImgDto;
import com.kinaboot.muscles.service.ProductService;
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
@RequestMapping("/admin/product/")
public class ProductController {
    @Autowired
    ProductService productService;

    private static final Logger logger = LoggerFactory.getLogger(ProductController.class);
    @GetMapping("")
    @ResponseBody
    public ResponseEntity<List<ProductDto>> productList() {
        logger.info("상품 목록 조회");
        return new ResponseEntity<>(productService.findAllProduct(), HttpStatus.OK);
    }
    @GetMapping("{productNo}")
    @ResponseBody
    public ResponseEntity<ProductDto> productDetails(@PathVariable Integer productNo) {
        logger.info("단 건 상품 조회");
        return new ResponseEntity<>(productService.findProduct(productNo), HttpStatus.OK);
    }
    @DeleteMapping("{productNo}")
    @ResponseBody
    public ResponseEntity<String> productRemove(@PathVariable Integer productNo) {
        logger.info("단 건 상품 삭제");
        productService.removeProduct(productNo);
        return new ResponseEntity<>("DEL_OK", HttpStatus.OK);
    }
    @PatchMapping("")
    @ResponseBody
    public ResponseEntity<String> productModify(@RequestBody ProductDto productDto) {
        logger.info("단 건 상품 수정");
        productService.modifyProduct(productDto);
        return new ResponseEntity<>("MOD_OK", HttpStatus.OK);
    }

    @GetMapping("detailImg/{productNo}")
    @ResponseBody
    public ResponseEntity<List<ProductImgDto>> productImgList(@PathVariable Integer productNo) {
        logger.info("[productNo] " + productNo + " 상세 이미지 목록 조회");
        return new ResponseEntity<>(productService.getProductDetailImgList(productNo), HttpStatus.OK);
    }

    @PostMapping("file/delete")
    public ResponseEntity<String> productImgRemove(String type, String fileName) {
        logger.info("type=[" + type + "]" + "fileName=[" + fileName + "] 이미지 삭제");
        String uploadPath = "C:\\Muscles\\src\\main\\webapp\\resources\\uploadImg\\product\\" + type + "\\";
        new File(uploadPath + fileName).delete();
        return new ResponseEntity<>("DEL_OK", HttpStatus.OK);
    }

    @PostMapping(value = "file/{type}/{productNo}", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    public ResponseEntity<List<ProductImgDto>> productImgAdd(MultipartFile[] uploadFile, @PathVariable String type, @PathVariable Integer productNo) throws IOException {
        // 서버 단에서 이미지 파일 체크 구현 필요
        List<ProductImgDto> productImgDtoList = new ArrayList<>();
        String uploadPath = "C:\\Muscles\\src\\main\\webapp\\resources\\img\\product\\" + type;
        for (MultipartFile file : uploadFile) {
            String uuid = UUID.randomUUID().toString();
            String uploadName = uuid + "_" + file.getOriginalFilename();
            File saveFile = new File(uploadPath, uploadName);
            file.transferTo(saveFile);
            ProductImgDto productImgDto = new ProductImgDto(productNo, uploadPath, uploadName, uuid);
            productImgDtoList.add(productImgDto);
        }
        return new ResponseEntity<>(productImgDtoList, HttpStatus.OK);
    }
}
