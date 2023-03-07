package com.kinaboot.muscles.dao;

import com.kinaboot.muscles.domain.ProductDto;
import com.kinaboot.muscles.domain.UserDto;

import java.util.List;

public interface ProductDao {
    List<ProductDto> selectByCategory(String category);
    int insert(ProductDto productDto);
    int deleteAll();
    int count();

    ProductDto select(Integer productNo);

    List<ProductDto> selectAll();
}
