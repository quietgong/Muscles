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
    public int findCartItem(String userId, Integer goodsNo) {
        return cartDao.select(userId, goodsNo);
    }

    @Override
    public List<CartDto> findCartItems(String userId) {
        return cartDao.selectAll(userId);
    }

    @Override
    public String addCartItem(CartDto cartDto) {
        // 추가하고자 하는 아이템이 이미 장바구니에 있을 때 추가 실패
        if(cartDao.select(cartDto.getUserId(), cartDto.getGoodsNo())!=0)
            return "ADD_FAIL";
        cartDao.insert(cartDto);
        return "ADD_OK";
    }

    @Override
    public int countCart(String userId) {
        return cartDao.count(userId);
    }

    @Override
    public int removeCartItem(String userId, Integer goodsNo) {
        return cartDao.deleteCartItem(userId, goodsNo);
    }
}
