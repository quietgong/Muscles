package com.kinaboot.muscles.controller;

import com.kinaboot.muscles.dao.ProductDao;
import com.kinaboot.muscles.domain.CartDto;
import com.kinaboot.muscles.domain.ProductDto;
import com.kinaboot.muscles.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import java.util.ArrayList;
import java.util.List;

@Controller
public class ProductController {
    @Autowired
    ProductService productService;
    @GetMapping("product/list")
    public String productList(String category, Model m){
        List<ProductDto> list = productService.productList(category);
        m.addAttribute("list",list);
        return "product/list";
    }
    @GetMapping("product/detail")
    public String productDetail(Integer productNo, Model m){
        ProductDto productDto = productService.getProductByNo(productNo);
        m.addAttribute(productDto);
        return "product/detail";
    }
    @PostMapping("/product/order")
    public String productOrder(CartDto cartDto, Model m){
        List<CartDto> orderItemList = new ArrayList<>();
        orderItemList.add(cartDto);
        m.addAttribute("list", orderItemList);
        return "order/page";
    }
}
