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

    @GetMapping("/chatting")
    public String chattingList() {
        return "chatRoom";
    }
    @GetMapping("/user")
    public String adminUser() {
        return "admin/user";
    }

    @GetMapping("/user/manage")
    @ResponseBody
    public ResponseEntity<List<UserDto>> getUser() {
        return new ResponseEntity<>(userService.getAllUser(), HttpStatus.OK);
    }

    @DeleteMapping("/user/manage/{userId}")
    @ResponseBody
    public ResponseEntity<String> removeUser(@PathVariable String userId) throws Exception {
        System.out.println("userid = " + userId);
        // 1. 유저 expiredDate 생성
        userService.removeUser(userId);
        // 2. 회원탈퇴 데이터에 운영자에 의한 탈퇴임을 기록
        userService.createQuit(userId);
        return new ResponseEntity<>("DEL_OK", HttpStatus.OK);
    }

    @GetMapping("/product")
    public String getProduct(Model m) {
        logger.info("상품관리 페이지 진입");

        List<ProductDto> productDtoList = productService.getAllProduct();
        m.addAttribute("list", productDtoList);
        return "admin/product";
    }

    @GetMapping("/product/manage")
    @ResponseBody
    public ResponseEntity<List<ProductDto>> getProductItems() {
        return new ResponseEntity<>(productService.getAllProduct(), HttpStatus.OK);
    }

    @GetMapping("/product/manage/detailImg/{productNo}")
    @ResponseBody
    public ResponseEntity<List<ProductImgDto>> getProductDetailImg(@PathVariable Integer productNo) {
        return new ResponseEntity<>(productService.getProductDetailImgList(productNo), HttpStatus.OK);
    }

    @DeleteMapping("/product/manage/{productNo}")
    @ResponseBody
    public ResponseEntity<String> removeProduct(@PathVariable Integer productNo) {
        productService.removeProduct(productNo);
        return new ResponseEntity<>("DEL_OK", HttpStatus.OK);
    }

    @PatchMapping("/product/manage/")
    @ResponseBody
    public ResponseEntity<String> modifyProduct(@RequestBody ProductDto productDto) {
        System.out.println("productDto = " + productDto);
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


    @GetMapping("/order")
    public String getOrder(SearchCondition sc, Model m) {
        List<OrderDto> orderDtoList = orderService.getAdminOrderList(sc);
        m.addAttribute(orderDtoList);
        return "admin/order";
    }

    @PostMapping("/order/accept/{orderNo}")
    @ResponseBody
    public ResponseEntity<String> acceptOrder(@PathVariable Integer orderNo) {
        orderService.acceptOrder(orderNo);
        return new ResponseEntity<>("ACCEPT_OK", HttpStatus.OK);
    }
}
