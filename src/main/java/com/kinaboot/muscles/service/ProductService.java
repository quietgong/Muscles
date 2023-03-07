package com.kinaboot.muscles.service;

import com.kinaboot.muscles.domain.ProductDto;

import java.util.List;

public interface ProductService {
    List<ProductDto> productList(String category);
    ProductDto getProductByNo(Integer productNo);

    List<ProductDto> getAllProduct();
}
