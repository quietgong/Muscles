package com.kinaboot.muscles.service;

import com.kinaboot.muscles.domain.CartDto;
import com.kinaboot.muscles.domain.ProductDto;

import java.util.List;

public interface CartService {
    int addCartItem(String userId, String productNo, String productQty);

    List<CartDto> getCartItems(String userId);

    int checkCartProduct(String userId, String productNo);

    int removeCartItem(String userId, List<String> deleteList);
}
