package com.kinaboot.muscles.service;

import com.kinaboot.muscles.domain.*;

import java.util.List;

public interface OrderService {
    List<OrderDto> getOrderList(String userId);

    int createOrder(String userId, OrderDto orderDto);

    int acceptOrder(Integer orderNo);

    List<OrderDto> getAdminOrderList(SearchCondition sc);

    List<OrderItemDto> getOrderItemList(Integer orderNo);

    OrderItemDto getOrderItem(Integer orderNo, Integer productNo);

    OrderDto getOrderDetail(Integer orderNo);

    int removeOrder(String userId, Integer orderNo);

    int getUserRecentOrderNo();
}
