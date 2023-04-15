package com.kinaboot.muscles.dao;

import com.kinaboot.muscles.domain.*;
import com.kinaboot.muscles.handler.SearchCondition;

import java.util.List;

public interface OrderDao {
    int updateStock(List<OrderItemDto> orderItemDtoList);

    OrderDto insertOrder(OrderDto orderDto);

    List<OrderDto> selectOrderAllByUser();

    OrderDto selectOrder(Integer orderNo);

    int updateOrderStatus(Integer bundleNo);

    List<OrderDto> selectOrderAll(SearchCondition sc);

    List<OrderDto> selectAll(String userId, SearchCondition sc);

    List<OrderItemDto> selectOrderItemList(Integer orderNo);

    OrderItemDto selectOrderItem(Integer orderNo, Integer goodsNo);

    DeliveryDto selectDelivery(int orderNo);

    PaymentDto selectPayment(int orderNo);
    int deleteOrder(Integer orderNo, String cancelReason);

}
