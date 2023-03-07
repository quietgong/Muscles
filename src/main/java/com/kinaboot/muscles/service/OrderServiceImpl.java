package com.kinaboot.muscles.service;

import com.kinaboot.muscles.dao.CartDao;
import com.kinaboot.muscles.dao.OrderDao;
import com.kinaboot.muscles.domain.CartDto;
import com.kinaboot.muscles.domain.DeliveryDto;
import com.kinaboot.muscles.domain.OrderDto;
import com.kinaboot.muscles.domain.PaymentDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
@Service
public class OrderServiceImpl implements OrderService{
    @Autowired
    OrderDao orderDao;
    @Autowired
    CartDao cartDao;
    @Override
    public int saveOrder(String userId, List<OrderDto> orderDtoList, DeliveryDto deliveryDto, PaymentDto paymentDto) {
        // 1. 구매 제품 카트에서 삭제
        List<String> deleteList = new ArrayList<>();
        for (OrderDto orderDto :
                orderDtoList) {
            deleteList.add(String.valueOf(orderDto.getProductNo()));
        }
        cartDao.deleteCartItem(userId, deleteList);
        // 2. 구매 제품 재고 수량 변경
        orderDao.updateStock(orderDtoList);
        // 3. 구매제품, 배송, 결제 정보 입력
        return orderDao.insertOrder(userId, orderDtoList, deliveryDto, paymentDto);
    }
}
