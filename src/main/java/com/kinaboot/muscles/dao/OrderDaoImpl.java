package com.kinaboot.muscles.dao;

import com.kinaboot.muscles.domain.*;
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
    public int updateStock(List<OrderItemDto> orderItemDtoList) {
        int rowCnt = 0;
        Map map = new HashMap();
        for (OrderItemDto orderItemDto :
                orderItemDtoList) {
            map.put("productNo", orderItemDto.getProductNo());
            session.update(namespace + "updateStock", map);
            rowCnt++;
        }
        return rowCnt;
    }

    @Override
    public int updateOrderStatus(Integer orderNo) {
        return session.update(namespace + "updateOrderStatus", orderNo);
    }

    @Override
    public List<OrderDto> selectOrderAll() {
        List<OrderDto> orderDtoList = session.selectList(namespace+"selectAllOrder");
        for(OrderDto orderDto : orderDtoList){
            DeliveryDto deliveryDto = session.selectOne(namespace + "selectDelivery", orderDto.getOrderNo());
            PaymentDto paymentDto = session.selectOne(namespace + "selectPayment", orderDto.getOrderNo());
            orderDto.setDeliveryDto(deliveryDto);
            orderDto.setPaymentDto(paymentDto);
        }
        return orderDtoList;
    }

    @Override
    public List<OrderDto> selectOrderAllByUser() {
        return session.selectList(namespace + "selectAllByUser");
    }

    @Override
    public OrderDto selectOrder(String userId, int bundleNo) {
        return null;
    }

    @Override
    public int insertOrder(String userId, OrderDto orderDto) {
        int row=0;
        row+=session.insert(namespace + "insertOrder", orderDto);
        row+=session.insert(namespace + "insertDelivery", orderDto.getDeliveryDto());
        row+=session.insert(namespace + "insertPayment", orderDto.getPaymentDto());
        return row;
    }
}
