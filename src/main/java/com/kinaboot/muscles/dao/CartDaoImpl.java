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
public class CartDaoImpl implements CartDao{
    @Autowired
    private SqlSession session;

    @Override
    public List<CartDto> selectAll(String userId) {
        return session.selectList(namespace + "selectAll", userId);
    }

    private static String namespace = "com.kinaboot.muscles.dao.cartMapper.";

    @Override
    public int select(String userId, String productNo) {
        Map map = new HashMap();
        map.put("userId", userId);
        map.put("productNo", productNo);
        return session.selectOne(namespace + "countCartItem", map);
    }

    @Override
    public int deleteCartItem(String userId, List<String> deleteList) {
        int rowCnt=0;
        for (int i = 0; i < deleteList.size(); i++) {
            Map map = new HashMap();
            map.put("userId", userId);
            map.put("productNo", deleteList.get(i));
            session.delete(namespace + "deleteItem", map);
        }
        return rowCnt;
    }

    @Override
    public int add(String userId, String productNo, String productQty) {
        Map map = new HashMap();
        map.put("userId", userId);
        map.put("productNo", productNo);
        map.put("productQty", productQty);
        return session.insert(namespace+"insert", map);
    }
}
