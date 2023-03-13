package com.kinaboot.muscles.dao;

import com.kinaboot.muscles.domain.FaqDto;
import com.kinaboot.muscles.domain.ProductDto;
import com.kinaboot.muscles.domain.SearchCondition;
import com.kinaboot.muscles.domain.UserDto;

import java.util.List;

public interface ProductDao {
    List<ProductDto> selectByCategory(SearchCondition sc);
    int insert(ProductDto productDto);
    int deleteAll();
    int count();

    ProductDto select(Integer productNo);

    List<ProductDto> selectAll();

    int deleteProduct(Integer productNo);

    int updateProduct(ProductDto productDto);

    List<FaqDto> selectFaqList(Integer productNo);

    int insertFaq(FaqDto faqDto);

    int selectByCategoryCnt(SearchCondition sc);
}
