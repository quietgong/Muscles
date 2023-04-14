package com.kinaboot.muscles.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kinaboot.muscles.dao.CartDao;
import com.kinaboot.muscles.dao.OrderDao;
import com.kinaboot.muscles.dao.UserDao;
import com.kinaboot.muscles.domain.*;
import com.kinaboot.muscles.handler.SearchCondition;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

@Service
public class OrderServiceImpl implements OrderService {
    @Autowired
    OrderDao orderDao;
    @Autowired
    UserDao userDao;
    @Autowired
    CartDao cartDao;
    @Autowired
    UserService userService;

    @Override
    public int removeOrder(int orderNo) {
        String userId = orderDao.selectOrder(orderNo).getUserId();
        int point =userService.findPoints(userId).get(0).getPoint();
        // 쿠폰 사용 취소 처리
        userDao.updateUserCouponStatus(orderNo);
        // 포인트 사용 취소 처리
        // 1. 포인트 환불
        userDao.updateUserPoint(userId, point, orderNo);
        // 2. 포인트 사용내역 삭제
        userDao.deleteUserPoint(orderNo);

        // 주문 취소 처리
        return orderDao.deleteOrder(orderNo);
    }

    @Override
    public int acceptOrder(int orderNo) {
        // 구매 제품 재고 수량 변경
        orderDao.updateStock(orderDao.selectOrderItemList(orderNo));

        // 포인트 적립
        OrderDto orderDto = orderDao.selectOrder(orderNo);
        String userId = orderDto.getUserId();

        // 적립 포인트 = 주문금액의 1%
        int pointPolicy = 1;
        int point = (int) (orderDto.getPaymentDto().getPrice() * 0.01 * pointPolicy);
        userDao.updateUserGetPoint(userId, point, orderNo);

        // 주문상태 변경
        return orderDao.updateOrderStatus(orderNo);
    }

    @Override
    public List<OrderItemDto> findOrderItems(Integer orderNo) {
        return orderDao.selectOrderItemList(orderNo);
    }

    @Override
    public OrderDto findOrder(Integer orderNo) {
        return orderDao.selectOrder(orderNo);
    }

    @Override
    public OrderItemDto findOrderItem(Integer orderNo, Integer goodsNo) {
        return orderDao.selectOrderItem(orderNo, goodsNo);
    }

    @Override
    public List<OrderDto> findAllOrders(SearchCondition sc) {
        List<OrderDto> orderDtoList = orderDao.selectOrderAll(sc);
        return getOrderDetail(orderDtoList);
    }

    @Override
    public List<OrderDto> findOrders(String userId) {
        List<OrderDto> orderDtoList = orderDao.selectAll(userId);
        return getOrderDetail(orderDtoList);
    }

    @Override
    public OrderDto addOrder(String orderData, int couponNo, int point) {
        OrderDto orderDto = null;
        try {
            orderDto = JsonToJava(orderData);
        } catch (JsonProcessingException e) {
            throw new RuntimeException(e);
        }
        String userId = orderDto.getUserId();

        // 구매 제품 장바구니에서 삭제
        List<OrderItemDto> orderItemDtoList = orderDto.getOrderItemDtoList();
        for (OrderItemDto orderItemDto : orderItemDtoList)
            cartDao.deleteCartItem(userId, orderItemDto.getGoodsNo());

        // 쿠폰 상태 변경
        if(couponNo!=0)
            userService.modifyCoupon(userId, couponNo);

        // 포인트 사용 적용
        if(point!=0)
            userService.modifyPoint(userId, -point, orderDto.getOrderNo());

        // 주문 정보 생성
        return orderDao.insertOrder(orderDto);
    }
    private List<OrderDto> getOrderDetail(List<OrderDto> orderDtoList){
        for(OrderDto orderDto : orderDtoList){
            orderDto.setOrderItemDtoList(orderDao.selectOrderItemList(orderDto.getOrderNo()));
            orderDto.setDeliveryDto(orderDao.selectDelivery(orderDto.getOrderNo()));
            orderDto.setPaymentDto(orderDao.selectPayment(orderDto.getOrderNo()));
        }
        return orderDtoList;
    }
    public OrderDto JsonToJava(String rowData) throws JsonProcessingException {
        ObjectMapper objectMapper = new ObjectMapper();
        return objectMapper.readValue(rowData, new TypeReference<OrderDto>() {
        });
    }
}
