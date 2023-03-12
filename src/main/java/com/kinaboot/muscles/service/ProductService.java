package com.kinaboot.muscles.service;

import com.kinaboot.muscles.domain.FaqDto;
import com.kinaboot.muscles.domain.ProductDto;
import com.kinaboot.muscles.domain.SearchCondition;

import java.util.List;

public interface ProductService {
    List<ProductDto> productList(String category, SearchCondition sc);
    ProductDto getProductByNo(Integer productNo);

    List<ProductDto> getAllProduct();

    int removeProduct(Integer productNo);

    int modifyProduct(ProductDto productDto);

    List<FaqDto> getFaqList(Integer productNo);

    int registerFaq(FaqDto faqDto);

    int getTotalCntByCategory(String category);
}
