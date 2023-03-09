package com.kinaboot.muscles.service;

import com.kinaboot.muscles.domain.*;

import java.util.List;

public interface OrderService {
    List<OrderDto> getOrderList(String userId);

    int createOrder(String userId, OrderDto orderDto);

    int acceptOrder(Integer orderNo);

    List<OrderDto> getAdminOrderList();

    List<OrderItemDto> getOrderItemList(Integer orderNo);

    OrderItemDto getOrderItem(Integer orderNo, Integer productNo);
}
