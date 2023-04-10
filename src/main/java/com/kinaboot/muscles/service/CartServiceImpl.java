package com.kinaboot.muscles.service;

import com.kinaboot.muscles.dao.CartDao;
import com.kinaboot.muscles.domain.CartDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CartServiceImpl implements CartService{
    @Autowired
    CartDao cartDao;

    @Override
    public int findCartItem(String userId, Integer productNo) {
        return cartDao.select(userId, productNo);
    }

    @Override
    public List<CartDto> findCartItems(String userId) {
        return cartDao.selectAll(userId);

    }

    @Override
    public int addCartItem(String userId, CartDto cartDto) {
        // 추가하고자 하는 아이템이 이미 장바구니에 있을 때 추가 실패
        if(cartDao.select(userId, cartDto.getProductNo())!=0)
            return 0;
        return cartDao.add(userId, cartDto);
    }

    @Override
    public int countCart(String userId) {
        return cartDao.count(userId);
    }

    @Override
    public int removeCartItem(String userId, Integer productNo) {
        return cartDao.deleteCartItem(userId, productNo);
    }
}
