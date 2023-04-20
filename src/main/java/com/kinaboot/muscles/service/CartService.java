package com.kinaboot.muscles.service;

import com.kinaboot.muscles.domain.CartDto;

import java.util.List;

public interface CartService {
    String addCartItem(CartDto cartDto);
    int findCartItem(String userId, Integer goodsNo);

    List<CartDto> findCartItems(String userId);

    int removeCartItem(String userId, Integer goodsNo);

    int countCart(String userId);
}
