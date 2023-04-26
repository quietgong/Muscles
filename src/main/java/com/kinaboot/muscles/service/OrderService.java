package com.kinaboot.muscles.service;

import com.kinaboot.muscles.domain.*;
import com.kinaboot.muscles.handler.SearchCondition;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

public interface OrderService {
    // 전체 주문 조회
    List<OrderDto> findAllOrders(SearchCondition sc);

    // 특정 유저 전체 주문 조회
    List<OrderDto> findOrders(SearchCondition sc);

    // 단건 주문 생성
    OrderDto addOrder(String orderData, Integer couponNo, Integer point);

    // 단건 주문 승인
    int acceptOrder(Integer orderNo);

    // 특정 주문 상품 단건 조회
    OrderItemDto findOrderItem(Integer orderNo, Integer goodsNo);

    // 특정 주문 단건 조회
    OrderDto findOrder(Integer orderNo);

    // 특정 주문 삭제
    int removeOrder(Integer orderNo, String cancelReason);
}
