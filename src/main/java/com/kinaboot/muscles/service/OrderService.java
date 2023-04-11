package com.kinaboot.muscles.service;

import com.kinaboot.muscles.domain.*;
import com.kinaboot.muscles.handler.SearchCondition;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

public interface OrderService {
    // 전체 주문 조회
    List<OrderDto> findAllOrders(SearchCondition sc);

    // 특정 유저 전체 주문 조회
    List<OrderDto> findOrders(String userId);

    // 단건 주문 생성
    int addOrder(String userId, String orderData, HttpServletRequest request);

    // 단건 주문 승인
    int acceptOrder(Integer orderNo);

    // 특정 주문 상품 전체 조회
    List<OrderItemDto> findOrderItems(Integer orderNo);

    // 특정 주문 상품 단건 조회
    OrderItemDto findOrderItem(Integer orderNo, Integer productNo);

    // 특정 주문 단건 조회
    OrderDto findOrder(Integer orderNo);

    // 특정 주문 삭제
    int removeOrder(String userId, Integer orderNo);

    // 주문 번호
    int findOrderNo();
}
