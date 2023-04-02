package com.kinaboot.muscles.dao;

import com.kinaboot.muscles.domain.*;
import com.kinaboot.muscles.handler.SearchCondition;

import java.util.List;

public interface OrderDao {
    int updateStock(List<OrderItemDto> orderItemDtoList);

    int insertOrder(String userId, OrderDto orderDto);

    List<OrderDto> selectOrderAllByUser();

    OrderDto selectOrder(Integer orderNo);

    int updateOrderStatus(Integer bundleNo);

    List<OrderDto> selectOrderAll(SearchCondition sc);

    List<OrderDto> selectAll(String userId);

    List<OrderItemDto> selectOrderItemList(Integer orderNo);

    OrderItemDto selectOrderItem(Integer orderNo, Integer productNo);

    int deleteOrder(Integer orderNo);

    int selectUserRecentOrderNo();
}
