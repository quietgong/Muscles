package com.kinaboot.muscles.service;

import com.kinaboot.muscles.domain.CartDto;
import com.kinaboot.muscles.domain.ProductDto;

import java.util.List;

public interface CartService {
    int addCartItem(String userId, CartDto cartDto);

    List<CartDto> getCartItems(String userId);

    int checkCartProduct(String userId, String productNo);

    int removeCartItem(String userId, List<String> deleteList);

    CartDto getItem(Integer productNo);
}
