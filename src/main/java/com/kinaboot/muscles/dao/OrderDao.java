package com.kinaboot.muscles.dao;

import com.kinaboot.muscles.domain.*;
import com.kinaboot.muscles.handler.SearchCondition;

import java.util.List;

public interface OrderDao {
    int updateStock(OrderItemDto orderItemDto);

    int insertOrder(OrderDto orderDto);

    OrderDto selectOrder(Integer orderNo);

    int updateOrderStatus(Integer bundleNo);

    List<OrderDto> selectOrderAll(SearchCondition sc);

    List<OrderDto> selectAll(SearchCondition sc);

    List<OrderItemDto> selectOrderItemList(Integer orderNo);

    OrderItemDto selectOrderItem(Integer orderNo, Integer goodsNo);

    DeliveryDto selectDelivery(int orderNo);

    PaymentDto selectPayment(int orderNo);

    int deleteOrder(Integer orderNo, String cancelReason);

    int insertOrderItem(OrderItemDto orderItemDto);

    int insertDelivery(DeliveryDto deliveryDto);

    int insertPayment(PaymentDto paymentDto);
    int deleteAll();
}
