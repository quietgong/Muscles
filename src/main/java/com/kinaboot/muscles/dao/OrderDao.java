package com.kinaboot.muscles.dao;

import com.kinaboot.muscles.domain.*;
import com.kinaboot.muscles.handler.SearchCondition;

import java.util.List;

public interface OrderDao {
    int updateStock(OrderItemDto orderItemDto);

    int insertOrder(OrderDto orderDto);

    OrderDto selectOrder(int orderNo);

    int updateOrderStatus(int bundleNo);

    List<OrderDto> selectOrderAll(SearchCondition sc);

    List<OrderDto> selectAll(SearchCondition sc);

    List<OrderItemDto> selectOrderItemList(int orderNo);

    OrderItemDto selectOrderItem(int orderNo, int goodsNo);

    DeliveryDto selectDelivery(int orderNo);

    PaymentDto selectPayment(int orderNo);

    int deleteOrder(int orderNo, String cancelReason);

    int insertOrderItem(OrderItemDto orderItemDto);

    int insertDelivery(DeliveryDto deliveryDto);

    int insertPayment(PaymentDto paymentDto);
    int deleteAll();

    int deleteAllOrderItem();

    int deleteAllPayment();

    int deleteAllDelivery();
}
