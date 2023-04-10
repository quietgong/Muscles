package com.kinaboot.muscles.service;

import com.kinaboot.muscles.domain.FaqDto;
import com.kinaboot.muscles.domain.ProductDto;
import com.kinaboot.muscles.domain.ProductImgDto;
import com.kinaboot.muscles.handler.SearchCondition;

import java.util.List;

public interface ProductService {
    List<ProductDto> findAllProduct();
    List<ProductDto> findProducts(SearchCondition sc);
    ProductDto findProduct(Integer productNo);
    int removeProduct(Integer productNo);
    int modifyProduct(ProductDto productDto);
    List<FaqDto> findFaqs(Integer productNo);
    int addFaq(FaqDto faqDto);
    int getTotalCntByCategory(SearchCondition sc);
    List<ProductImgDto> getProductDetailImgList(Integer productNo);
}
