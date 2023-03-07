package com.kinaboot.muscles.service;

import com.kinaboot.muscles.domain.CartDto;
import com.kinaboot.muscles.domain.DeliveryDto;
import com.kinaboot.muscles.domain.OrderDto;
import com.kinaboot.muscles.domain.PaymentDto;

import java.util.List;

public interface OrderService {
    int saveOrder(String userId, List<OrderDto> orderDtoList, DeliveryDto deliveryDto, PaymentDto paymentDto);
}
