package com.kinaboot.muscles.dao;

import com.kinaboot.muscles.domain.CartDto;
import com.kinaboot.muscles.domain.ProductDto;

import java.util.List;

public interface CartDao {
    int add(String userId, CartDto cartDto);

    List<CartDto> selectAll(String userId);

    int select(String userId, String productNo);

    int deleteCartItem(String userId, List<String> deleteList);

    CartDto selectItem(Integer productNo);
}
