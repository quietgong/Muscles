package com.kinaboot.muscles.dao;

import com.kinaboot.muscles.domain.CartDto;

import java.util.List;

public interface CartDao {
    int insert(CartDto cartDto);

    List<CartDto> selectAll(String userId);

    int select(String userId, Integer goodsNo);

    int deleteCartItem(String userId, Integer goodsNo);

    int count(String userId);

    int deleteAll();
}
