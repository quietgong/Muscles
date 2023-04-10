package com.kinaboot.muscles.service;

import com.kinaboot.muscles.domain.CartDto;
import com.kinaboot.muscles.domain.ProductDto;

import java.util.List;

public interface CartService {
    int addCartItem(String userId, CartDto cartDto);
    int findCartItem(String userId, Integer productNo);

    List<CartDto> findCartItems(String userId);

    int removeCartItem(String userId, Integer productNo);

    int countCart(String userId);
}
