package com.kinaboot.muscles.service;

import com.kinaboot.muscles.dao.CartDao;
import com.kinaboot.muscles.domain.CartDto;
import com.kinaboot.muscles.domain.ProductDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CartServiceImpl implements CartService{
    @Autowired
    CartDao cartDao;
    @Override
    public int addCartItem(String userId, CartDto cartDto) {
        return cartDao.add(userId, cartDto);
    }

    @Override
    public int checkCartProduct(String userId, Integer productNo) {
        return cartDao.select(userId, productNo);
    }

    public List<CartDto> getCartItems(String userId) {
        return cartDao.selectAll(userId);
    }

    @Override
    public CartDto getItem(Integer productNo) {
        return cartDao.selectItem(productNo);
    }

    @Override
    public int removeCartItem(String userId, Integer productNo) {
        return cartDao.deleteCartItem(userId, productNo);
    }
}
