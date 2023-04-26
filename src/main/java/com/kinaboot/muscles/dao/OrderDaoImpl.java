package com.kinaboot.muscles.dao;

import com.kinaboot.muscles.domain.*;
import com.kinaboot.muscles.handler.SearchCondition;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;

@Repository
public class OrderDaoImpl implements OrderDao {
    @Autowired
    private SqlSession session;
    private static String namespace = "com.kinaboot.muscles.dao.orderMapper.";

    @Override
    public List<OrderDto> selectAll(SearchCondition sc) {
        return session.selectList(namespace + "selectOrderList", sc);
    }

    @Override
    public List<OrderDto> selectOrderAll(SearchCondition sc) {
        return session.selectList(namespace + "selectOrderAllList", sc);
    }

    @Override
    public List<OrderItemDto> selectOrderItemList(int orderNo) {
        return session.selectList(namespace + "selectOrderItemList", orderNo);
    }

    @Override
    public DeliveryDto selectDelivery(int orderNo) {
        return session.selectOne(namespace + "selectDelivery", orderNo);
    }

    @Override
    public PaymentDto selectPayment(int orderNo) {
        return session.selectOne(namespace + "selectPayment", orderNo);
    }

    @Override
    public OrderDto selectOrder(int orderNo) {
        return session.selectOne(namespace + "selectOrder", orderNo);
    }

    @Override
    public OrderItemDto selectOrderItem(int orderNo, int goodsNo) {
        HashMap<String, Integer> map = new HashMap<>();
        map.put("orderNo", orderNo);
        map.put("goodsNo", goodsNo);
        return session.selectOne(namespace + "selectOrderItem", map);
    }

    @Override
    public int insertOrderItem(OrderItemDto orderItemDto) {
        return session.insert(namespace + "insertOrderItem", orderItemDto);
    }

    @Override
    public int insertDelivery(DeliveryDto deliveryDto) {
        return session.insert(namespace + "insertDelivery", deliveryDto);
    }

    @Override
    public int insertPayment(PaymentDto paymentDto) {
        return session.insert(namespace + "insertPayment", paymentDto);
    }

    @Override
    public int insertOrder(OrderDto orderDto) {
        session.insert(namespace + "insertOrder", orderDto);
        return session.selectOne(namespace + "newOrderNo");
    }

    @Override
    public int updateStock(OrderItemDto orderItemDto) {
        HashMap<String, Integer> map = new HashMap<>();
        map.put("goodsNo", orderItemDto.getGoodsNo());
        map.put("goodsQty", orderItemDto.getGoodsQty());
        return session.update(namespace + "updateStock", map);
    }

    @Override
    public int updateOrderStatus(int orderNo) {
        return session.update(namespace + "updateOrderStatus", orderNo);
    }

    @Override
    public int deleteOrder(int orderNo, String cancelReason) {
        HashMap<String, String> map = new HashMap<>();
        map.put("orderNo", String.valueOf(orderNo));
        map.put("cancelReason", cancelReason);
        return session.delete(namespace + "deleteOrder", map);
    }

    @Override
    public int deleteAll() {
        return session.delete(namespace + "deleteAll");
    }

    @Override
    public int deleteAllOrderItem() {
        return session.delete(namespace + "deleteAllOrderItem");
    }

    @Override
    public int deleteAllPayment() {
        return session.delete(namespace + "deleteAllPayment");
    }

    @Override
    public int deleteAllDelivery() {
        return session.delete(namespace + "deleteAllDelivery");
    }
}
