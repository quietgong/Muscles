package com.kinaboot.muscles.service;

import com.kinaboot.muscles.dao.CartDao;
import com.kinaboot.muscles.dao.OrderDao;
import com.kinaboot.muscles.dao.UserDao;
import com.kinaboot.muscles.domain.*;
import com.kinaboot.muscles.handler.SearchCondition;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class OrderServiceImpl implements OrderService{
    @Autowired
    OrderDao orderDao;
    @Autowired
    UserDao userDao;
    @Autowired
    CartDao cartDao;

    @Override
    public int removeOrder(String userId, Integer orderNo) {
        // 해당 주문에 쿠폰이 사용된 경우, 쿠폰 상태를 사용가능으로 변경
        List<CouponDto> couponDtoList = userDao.selectUserCoupon(userId);
        for(CouponDto couponDto : couponDtoList){
            if(couponDto.getStatus().equals(String.valueOf(orderNo))){
                userDao.updateUserCouponStatus(userId, couponDto.getCouponName(), "사용가능");
                break;
            }
        }
        // 포인트 환불
        List<PointDto> pointDtoList = userDao.selectUserPoint(userId);
        for(PointDto pointDto : pointDtoList){
            if(pointDto.getPointName().equals(String.valueOf(orderNo))){
                userDao.updateUserPoint(userId, pointDto.getPoint(), String.valueOf(orderNo));
                userDao.deleteUserPoint(userId, pointDto.getPointName());
                break;
            }
        }
        return orderDao.deleteOrder(orderNo);
    }

    @Override
    public int acceptOrder(Integer orderNo) {
        // 구매 제품 재고 수량 변경
        orderDao.updateStock(orderDao.selectOrderItemList(orderNo));
        // 포인트 적립
        OrderDto orderDto = orderDao.selectOrder(orderNo);
        String userId = orderDto.getUserId();
        // 적립 포인트 = 주문금액의 1%
        int point = (int) (orderDto.getPaymentDto().getPrice()*0.01);
        userDao.updateUserGetPoint(userId, point, orderNo);
        // 주문상태 변경
        return orderDao.updateOrderStatus(orderNo);
    }

    @Override
    public List<OrderItemDto> getOrderItemList(Integer orderNo) {
        return orderDao.selectOrderItemList(orderNo);
    }

    @Override
    public OrderDto getOrderDetail(Integer orderNo) {
        return orderDao.selectOrder(orderNo);
    }

    @Override
    public OrderItemDto getOrderItem(Integer orderNo, Integer productNo) {
        return orderDao.selectOrderItem(orderNo, productNo);
    }

    @Override
    public List<OrderDto> getAdminOrderList(SearchCondition sc) {
        return orderDao.selectOrderAll(sc);
    }

    @Override
    public List<OrderDto> getOrderList(String userId) {
        return orderDao.selectAll(userId);
    }

    @Override
    public int getUserRecentOrderNo() {
        return orderDao.selectUserRecentOrderNo();
    }

    @Override
    public int createOrder(String userId, OrderDto orderDto) {
        // 1. 구매 제품 카트에서 삭제
        List<OrderItemDto> orderItemDtoList = orderDto.getOrderItemDtoList();
        List<String> deleteList = new ArrayList<>();
        for(OrderItemDto orderItemDto : orderItemDtoList)
                deleteList.add(String.valueOf(orderItemDto.getProductNo()));
        cartDao.deleteCartItem(userId, deleteList);

        // 2. 구매제품, 배송, 결제 정보 입력
        return orderDao.insertOrder(userId, orderDto);
    }
}
