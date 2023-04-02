package com.kinaboot.muscles.service;

import com.kinaboot.muscles.domain.FaqDto;
import com.kinaboot.muscles.domain.ProductDto;
import com.kinaboot.muscles.domain.ProductImgDto;
import com.kinaboot.muscles.handler.SearchCondition;

import java.util.List;

public interface ProductService {
    List<ProductDto> productList(SearchCondition sc);
    ProductDto getProductByNo(Integer productNo);

    List<ProductDto> getAllProduct();

    int removeProduct(Integer productNo);

    int modifyProduct(ProductDto productDto);

    List<FaqDto> getFaqList(Integer productNo);

    int registerFaq(FaqDto faqDto);

    int getTotalCntByCategory(SearchCondition sc);

    List<ProductImgDto> getProductDetailImgList(Integer productNo);
}
