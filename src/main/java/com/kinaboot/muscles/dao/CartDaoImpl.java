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

    private static String namespace = "com.kinaboot.muscles.dao.cartMapper.";

    @Override
    public int count(String userId) {
        return session.selectOne(namespace + "count", userId);
    }

    @Override
    public List<CartDto> selectAll(String userId) {
        return session.selectList(namespace + "selectAll", userId);
    }

    @Override
    public int select(String userId, Integer goodsNo) {
        Map<String, String> map = new HashMap<>();
        map.put("userId", userId);
        map.put("goodsNo", String.valueOf(goodsNo));
        return session.selectOne(namespace + "countCartItem", map);
    }

    @Override
    public int insert(CartDto cartDto) {
        return session.insert(namespace + "insert", cartDto);
    }

    @Override
    public int deleteCartItem(String userId, Integer goodsNo) {
        Map<String, String> map = new HashMap<>();
        map.put("userId", userId);
        map.put("goodsNo", String.valueOf(goodsNo));
        return session.delete(namespace + "deleteItem", map);
    }

    @Override
    public int deleteAll() {
        return session.delete(namespace + "deleteAll");
    }
}
