package com.kinaboot.muscles.service;

import com.kinaboot.muscles.TestConfigure;
import com.kinaboot.muscles.dao.CartDao;
import com.kinaboot.muscles.domain.CartDto;
import org.checkerframework.checker.units.qual.C;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.ArrayList;
import java.util.List;

import static org.junit.Assert.*;

public class CartServiceImplTest extends TestConfigure {
    @Autowired
    CartDao cartDao;

    private String userId = "test";

    @Test
    public void findCartItem() {
        int goodsNo = 1;
        cartDao.select(userId, goodsNo);
    }

    @Test
    public void findCartItems() {
        cartDao.selectAll(userId);
    }

    @Test
    public void addCartItem() {
        List<CartDto> cartDtoList = new ArrayList<>();

        CartDto cartDto = new CartDto();
        cartDto.setUserId(userId);
        cartDto.setGoodsNo(1);

        // 추가하고자 하는 아이템이 장바구니에 없다면 추가
        if(cartDao.select(userId, cartDto.getGoodsNo())==0)
            cartDtoList.add(cartDto);
        assertEquals(cartDtoList.size(),1);

        // 추가하고자 하는 아이템이 장바구니에 이미 있다면 추가하지 않는다
        if(cartDao.select(userId, cartDto.getGoodsNo())!=0)
            cartDtoList.add(cartDto);
        assertEquals(cartDtoList.size(),1);
    }

    @Test
    public void countCart() {
        cartDao.count(userId);
    }

    @Test
    public void removeCartItem() {
        int goodsNo = 0;
        cartDao.deleteCartItem(userId, goodsNo);
    }
}