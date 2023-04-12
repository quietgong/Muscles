package com.kinaboot.muscles.dao;

import com.kinaboot.muscles.domain.CartDto;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class CartDaoImpl implements CartDao {
    @Autowired
    private SqlSession session;

    @Override
    public List<CartDto> selectAll(String userId) {
        return session.selectList(namespace + "selectAll", userId);
    }

    @Override
    public int count(String userId) {
        return session.selectOne(namespace + "count", userId);
    }

    private static String namespace = "com.kinaboot.muscles.dao.cartMapper.";

    @Override
    public int select(String userId, Integer goodsNo) {
        Map<String, String> map = new HashMap<>();
        map.put("userId", userId);
        map.put("goodsNo", String.valueOf(goodsNo));
        return session.selectOne(namespace + "countCartItem", map);
    }

    @Override
    public int deleteCartItem(String userId, Integer goodsNo) {
        Map<String, String> map = new HashMap<>();
        map.put("userId", userId);
        map.put("goodsNo", String.valueOf(goodsNo));
        return session.delete(namespace + "deleteItem", map);
    }

    @Override
    public CartDto selectItem(Integer goodsNo) {
        return session.selectOne(namespace + "selectItem", goodsNo);
    }

    @Override
    public int add(String userId, CartDto cartDto) {
        Map<String, String> map = new HashMap<>();
        map.put("userId", userId);
        map.put("goodsNo", String.valueOf(cartDto.getGoodsNo()));
        map.put("goodsName", cartDto.getGoodsName());
        map.put("goodsCategory", cartDto.getGoodsCategory());
        map.put("goodsCategoryDetail", cartDto.getGoodsCategoryDetail());
        map.put("goodsPrice", String.valueOf(cartDto.getGoodsPrice()));
        map.put("goodsQty", String.valueOf(cartDto.getGoodsQty()));
        return session.insert(namespace + "insert", map);
    }
}
