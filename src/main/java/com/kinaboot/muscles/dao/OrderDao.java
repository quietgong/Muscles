package com.kinaboot.muscles.dao;

import com.kinaboot.muscles.domain.*;

import java.util.List;

public interface OrderDao {
    int updateStock(List<OrderItemDto> orderItemDtoList);

    int insertOrder(String userId, OrderDto orderDto);

    List<OrderDto> selectOrderAllByUser();

    OrderDto selectOrder(String userId, int bundleNo);
    OrderDto selectOrder(Integer orderNo);

    int updateOrderStatus(Integer bundleNo);

    List<OrderDto> selectOrderAll();

    List<OrderDto> selectAll(String userId);

    List<OrderItemDto> selectOrderItemList(Integer orderNo);

    OrderItemDto selectOrderItem(Integer orderNo, Integer productNo);
}
