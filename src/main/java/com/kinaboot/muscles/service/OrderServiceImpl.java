package com.kinaboot.muscles.service;

import com.kinaboot.muscles.dao.CartDao;
import com.kinaboot.muscles.dao.OrderDao;
import com.kinaboot.muscles.domain.*;
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
    public int acceptOrder(Integer orderNo) {
        return orderDao.updateOrderStatus(orderNo);
    }

    @Override
    public List<OrderItemDto> getOrderItemList(Integer orderNo) {
        return orderDao.selectOrderItemList(orderNo);
    }

    @Override
    public List<OrderDto> getAdminOrderList() {
        return orderDao.selectOrderAll();
    }

    @Override
    public List<OrderDto> getOrderList(String userId) {
        return orderDao.selectAll(userId);
    }

//    @Override
//    public int acceptOrder(Integer orderNo) {
//        return orderDao.updateOrderStatus(orderNo);
//    }

    @Override
    public int createOrder(String userId, OrderDto orderDto) {
        // 1. 구매 제품 카트에서 삭제
        List<OrderItemDto> orderItemDtoList = orderDto.getOrderItemDtoList();
        List<String> deleteList = new ArrayList<>();
        for(OrderItemDto orderItemDto : orderItemDtoList)
                deleteList.add(String.valueOf(orderItemDto.getProductNo()));
        cartDao.deleteCartItem(userId, deleteList);
        // 2. 구매 제품 재고 수량 변경
        orderDao.updateStock(orderItemDtoList);
        // 3. 구매제품, 배송, 결제 정보 입력
        return orderDao.insertOrder(userId, orderDto);
    }
}
