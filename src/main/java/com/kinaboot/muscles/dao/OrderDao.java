package com.kinaboot.muscles.dao;

import com.kinaboot.muscles.domain.CartDto;
import com.kinaboot.muscles.domain.DeliveryDto;
import com.kinaboot.muscles.domain.OrderDto;
import com.kinaboot.muscles.domain.PaymentDto;

import java.util.List;

public interface OrderDao {
    int updateStock(List<OrderDto> orderDtoList);

    int insertOrder(String userId, List<OrderDto> orderDtoList, DeliveryDto deliveryDto, PaymentDto paymentDto);
}
