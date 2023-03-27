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
    public List<OrderDto> selectAll(String userId) {
        // userId별 주문목록 가져오기
        List<OrderDto> orderDtoList = session.selectList(namespace + "selectOrderList", userId);
        for(OrderDto orderDto: orderDtoList) {
            // 해당 주문정보의 orderNo를 통해 주문상품 정보, 배송정보, 결제정보를 가져온다.
            int orderNo = orderDto.getOrderNo();
            orderDto.setOrderItemDtoList(session.selectList(namespace + "selectOrderItemList", orderNo));
            orderDto.setDeliveryDto(session.selectOne(namespace + "selectDelivery", orderNo));
            orderDto.setPaymentDto(session.selectOne(namespace + "selectPayment", orderNo));
        }
        return orderDtoList;
    }

    @Override
    public int updateStock(List<OrderItemDto> orderItemDtoList) {
        Map map = new HashMap();
        for (OrderItemDto orderItemDto : orderItemDtoList) {
            map.put("productNo", orderItemDto.getProductNo());
            map.put("productQty", orderItemDto.getProductQty());
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
        List<OrderDto> orderDtoList = session.selectList(namespace + "selectOrderAllList", sc);
        for(OrderDto orderDto: orderDtoList) {
            // 해당 주문정보의 orderNo를 통해 주문상품 정보, 배송정보, 결제정보를 가져온다.
            int orderNo = orderDto.getOrderNo();
            orderDto.setOrderItemDtoList(session.selectList(namespace + "selectOrderItemList", orderNo));
            orderDto.setDeliveryDto(session.selectOne(namespace + "selectDelivery", orderNo));
            orderDto.setPaymentDto(session.selectOne(namespace + "selectPayment", orderNo));
        }
        return orderDtoList;
    }

    @Override
    public List<OrderItemDto> selectOrderItemList(Integer orderNo) {
        return session.selectList(namespace + "selectOrderItemList", orderNo);
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
    public OrderItemDto selectOrderItem(Integer orderNo, Integer productNo) {
        Map map = new HashMap();
        map.put("orderNo", orderNo);
        map.put("productNo", productNo);
        return session.selectOne(namespace+"selectOrderItem",map);
    }

    @Override
    public int selectUserRecentOrderNo() {
        return session.selectOne(namespace + "selectUserRecentOrderNo");
    }

    @Override
    public List<OrderDto> selectOrderAllByUser() {
        return session.selectList(namespace + "selectAllByUser");
    }

    @Override
    public int insertOrder(String userId, OrderDto orderDto) {
        // 주문 정보 생성
        session.insert(namespace + "insertOrder", orderDto);

        // 주문상품 정보 생성
        for(OrderItemDto orderItemDto : orderDto.getOrderItemDtoList())
            session.insert(namespace + "insertOrderItem", orderItemDto);

        // 배송 정보 생성
        session.insert(namespace + "insertDelivery", orderDto.getDeliveryDto());

        // 결제 정보 생성
        session.insert(namespace + "insertPayment", orderDto.getPaymentDto());
        return 0;
    }
}
