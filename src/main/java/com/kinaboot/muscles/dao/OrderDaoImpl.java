package com.kinaboot.muscles.dao;

import com.kinaboot.muscles.domain.*;
import com.kinaboot.muscles.handler.SearchCondition;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class OrderDaoImpl implements OrderDao {
    @Autowired
    private SqlSession session;
    private static String namespace = "com.kinaboot.muscles.dao.orderMapper.";

    @Override
    public List<OrderDto> selectAll(String userId, SearchCondition sc) {
        sc.setUserId(userId);
        return session.selectList(namespace + "selectOrderList", sc);
    }

    @Override
    public int updateStock(List<OrderItemDto> orderItemDtoList) {
        HashMap<String, Integer> map = new HashMap<>();
        for (OrderItemDto orderItemDto : orderItemDtoList) {
            map.put("goodsNo", orderItemDto.getGoodsNo());
            map.put("goodsQty", orderItemDto.getGoodsQty());
            session.update(namespace + "updateStock", map);
        }
        return 0;
    }

    @Override
    public int deleteOrder(Integer orderNo) {
        return session.delete(namespace + "deleteOrder", orderNo);
    }

    @Override
    public int updateOrderStatus(Integer orderNo) {
        return session.update(namespace + "updateOrderStatus", orderNo);
    }


    @Override
    public List<OrderDto> selectOrderAll(SearchCondition sc) {
        return session.selectList(namespace + "selectOrderAllList", sc);
    }

    @Override
    public List<OrderItemDto> selectOrderItemList(Integer orderNo) {
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
    public OrderDto selectOrder(Integer orderNo) {
        OrderDto orderDto = session.selectOne(namespace + "selectOrder", orderNo);
        List<OrderItemDto> orderItemDtoList = session.selectList(namespace + "selectOrderItemList", orderNo);
        DeliveryDto deliveryDto = session.selectOne(namespace + "selectDelivery", orderNo);
        PaymentDto paymentDto = session.selectOne(namespace + "selectPayment", orderNo);

        orderDto.setOrderItemDtoList(orderItemDtoList);
        orderDto.setDeliveryDto(deliveryDto);
        orderDto.setPaymentDto(paymentDto);

        return orderDto;
    }

    @Override
    public OrderItemDto selectOrderItem(Integer orderNo, Integer goodsNo) {
        HashMap<String, Integer> map = new HashMap<>();
        map.put("orderNo", orderNo);
        map.put("goodsNo", goodsNo);
        return session.selectOne(namespace + "selectOrderItem", map);
    }
    @Override
    public List<OrderDto> selectOrderAllByUser() {
        return session.selectList(namespace + "selectAllByUser");
    }

    @Override
    public OrderDto insertOrder(OrderDto orderDto) {
        // 주문 정보 생성
        session.insert(namespace + "insertOrder", orderDto);

        // 생성한 주문 번호 반환
        int orderNo = session.selectOne(namespace+"newOrderNo");

        // 주문상품 정보 생성
        List<OrderItemDto> orderItemDtoList = orderDto.getOrderItemDtoList();
        for (OrderItemDto orderItemDto : orderItemDtoList) {
            orderItemDto.setOrderNo(orderNo);
            session.insert(namespace + "insertOrderItem", orderItemDto);
        }
        // 배송 정보 생성
        DeliveryDto deliveryDto = orderDto.getDeliveryDto();
        deliveryDto.setOrderNo(orderNo);
        session.insert(namespace + "insertDelivery", deliveryDto);

        // 결제 정보 생성
        PaymentDto paymentDto = orderDto.getPaymentDto();
        paymentDto.setOrderNo(orderNo);
        session.insert(namespace + "insertPayment", paymentDto);

        OrderDto newOrderDto = session.selectOne(namespace + "selectOrder", orderNo);
        newOrderDto.setOrderItemDtoList(orderItemDtoList);
        newOrderDto.setDeliveryDto(deliveryDto);
        newOrderDto.setPaymentDto(paymentDto);

        return newOrderDto;
    }
}
