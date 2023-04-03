package com.kinaboot.muscles.controller;

import com.kinaboot.muscles.domain.*;
import com.kinaboot.muscles.handler.SearchCondition;
import com.kinaboot.muscles.service.OrderService;
import com.kinaboot.muscles.service.ProductService;
import com.kinaboot.muscles.service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/admin")
public class AdminController {
    private static final Logger logger = LoggerFactory.getLogger(AdminController.class);
    @Autowired
    UserService userService;
    @Autowired
    ProductService productService;
    @Autowired
    OrderService orderService;

    // 유저 목록
    @GetMapping("/user/")
    @ResponseBody
    public ResponseEntity<List<UserDto>> getUser() {
        logger.info("유저 목록 출력");
        return new ResponseEntity<>(userService.getAllUser(), HttpStatus.OK);
    }
    // 유저 탈퇴 처리
    @DeleteMapping("/user/{userId}")
    @ResponseBody
    public ResponseEntity<String> removeUser(@PathVariable String userId) {
        logger.info("ID : " + userId + " 탈퇴 처리");
        try {
            userService.removeUser(userId);
            return new ResponseEntity<>("DEL_OK", HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>("DEL_FAIL", HttpStatus.BAD_REQUEST);
        }
    }

    /* 상품관리 */
    @GetMapping("/product/")
    @ResponseBody
    public ResponseEntity<List<ProductDto>> getProductItems() {
        logger.info("상품관리 진입");
        return new ResponseEntity<>(productService.getAllProduct(), HttpStatus.OK);
    }

    @GetMapping("/product/detailImg/{productNo}")
    @ResponseBody
    public ResponseEntity<List<ProductImgDto>> getProductDetailImg(@PathVariable Integer productNo) {
        return new ResponseEntity<>(productService.getProductDetailImgList(productNo), HttpStatus.OK);
    }

    @DeleteMapping("/product/{productNo}")
    @ResponseBody
    public ResponseEntity<String> removeProduct(@PathVariable Integer productNo) {
        productService.removeProduct(productNo);
        return new ResponseEntity<>("DEL_OK", HttpStatus.OK);
    }

    @PatchMapping("/product/")
    @ResponseBody
    public ResponseEntity<String> modifyProduct(@RequestBody ProductDto productDto) {
        productService.modifyProduct(productDto);
        return new ResponseEntity<>("MOD_OK", HttpStatus.OK);
    }

    @PostMapping("/product/file/delete")
    public ResponseEntity<String> fileDeleteTest(String type, String fileName) {
        String uploadPath = "C:\\Muscles\\src\\main\\webapp\\resources\\uploadImg\\product\\" + type + "\\";
        File file = new File(uploadPath + fileName);
        file.delete();
        return new ResponseEntity<>("DEL_OK", HttpStatus.OK);
    }

    @PostMapping(value = "/product/file/{type}/{productNo}", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    public ResponseEntity<List<ProductImgDto>> uploadTest(MultipartFile[] uploadFile, @PathVariable String type, @PathVariable Integer productNo) throws IOException {
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
    /* 상품관리 */

    @GetMapping("/order")
    public String getOrder(SearchCondition sc, Model m) {
        m.addAttribute("orderDtoList", orderService.getAdminOrderList(sc));
        return "admin/order";
    }

    @PostMapping("/order/{orderNo}")
    @ResponseBody
    public ResponseEntity<String> acceptOrder(@PathVariable Integer orderNo) {
        orderService.acceptOrder(orderNo);
        return new ResponseEntity<>("ACCEPT_OK", HttpStatus.OK);
    }
}
