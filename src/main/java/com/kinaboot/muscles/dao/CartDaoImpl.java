package com.kinaboot.muscles.dao;

import com.kinaboot.muscles.domain.CartDto;
import com.kinaboot.muscles.domain.ProductDto;
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

    private static String namespace = "com.kinaboot.muscles.dao.cartMapper.";

    @Override
    public int select(String userId, Integer productNo) {
        Map map = new HashMap();
        map.put("userId", userId);
        map.put("productNo", productNo);
        return session.selectOne(namespace + "countCartItem", map);
    }

    @Override
    public int deleteCartItem(String userId, Integer productNo) {
        Map map = new HashMap();
        map.put("userId", userId);
        map.put("productNo", productNo);
        return session.delete(namespace + "deleteItem", map);
    }

    @Override
    public CartDto selectItem(Integer productNo) {
        return session.selectOne(namespace + "selectItem", productNo);
    }

    @Override
    public int add(String userId, CartDto cartDto) {
        Map map = new HashMap();
        map.put("userId", userId);
        map.put("productNo", cartDto.getProductNo());
        map.put("productName", cartDto.getProductName());
        map.put("productCategory", cartDto.getProductCategory());
        map.put("productPrice", cartDto.getProductPrice());
        map.put("productQty", cartDto.getProductQty());
        return session.insert(namespace + "insert", map);
    }
}
