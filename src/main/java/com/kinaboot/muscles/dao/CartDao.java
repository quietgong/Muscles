package com.kinaboot.muscles.dao;

import com.kinaboot.muscles.domain.CartDto;

import java.util.List;

public interface CartDao {
    int add(String userId, CartDto cartDto);

    List<CartDto> selectAll(String userId);

    int select(String userId, Integer goodsNo);

    int deleteCartItem(String userId, Integer goodsNo);

    CartDto selectItem(Integer goodsNo);

    int count(String userId);
}
