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
    public int removeOrder(String userId, Integer orderNo) {
        // 해당 주문에 쿠폰이 사용된 경우, 쿠폰 상태를 사용가능으로 변경
        List<CouponDto> couponDtoList = userDao.selectUserCoupon(userId);
        for (CouponDto couponDto : couponDtoList) {
            if (couponDto.getStatus().equals(String.valueOf(orderNo))) {
                userDao.updateUserCouponStatus(userId, couponDto.getCouponName(), "사용가능");
                break;
            }
        }
        // 포인트 환불
        List<PointDto> pointDtoList = userDao.selectUserPoint(userId);
        for (PointDto pointDto : pointDtoList) {
            if (pointDto.getPointName().equals(String.valueOf(orderNo))) {
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
        int point = (int) (orderDto.getPaymentDto().getPrice() * 0.01);
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
    public OrderItemDto findOrderItem(Integer orderNo, Integer productNo) {
        return orderDao.selectOrderItem(orderNo, productNo);
    }

    @Override
    public List<OrderDto> findAllOrders(SearchCondition sc) {
        return orderDao.selectOrderAll(sc);
    }

    @Override
    public List<OrderDto> findOrders(String userId) {
        List<OrderDto> orderDtoList = orderDao.selectAll(userId);
        return orderDao.getOrderDtoList(orderDtoList);
    }

    @Override
    public int findOrderNo() {
        return orderDao.selectUserRecentOrderNo();
    }

    @Override
    public int addOrder(String userId, String orderData, HttpServletRequest request) {
        OrderDto orderDto = null;
        try {
            orderDto = JsonToJava(orderData);
        } catch (JsonProcessingException e) {
            throw new RuntimeException(e);
        }
        int point = Integer.parseInt(request.getParameter("point"));
        String couponName = request.getParameter("couponName");

        // 구매 제품 장바구니에서 삭제
        List<OrderItemDto> orderItemDtoList = orderDto.getOrderItemDtoList();
        for (OrderItemDto orderItemDto : orderItemDtoList)
            cartDao.deleteCartItem(userId, orderItemDto.getProductNo());

        // 쿠폰 상태 변경
        userService.modifyCoupon(userId, couponName, String.valueOf(orderDto.getOrderNo()));

        // 포인트 사용 적용
        userService.modifyPoint(userId, point, String.valueOf(orderDto.getOrderNo()));

        // 주문 정보 생성
        return orderDao.insertOrder(userId, orderDto);
    }
    public OrderDto JsonToJava(String rowData) throws JsonProcessingException {
        ObjectMapper objectMapper = new ObjectMapper();
        return objectMapper.readValue(rowData, new TypeReference<OrderDto>() {
        });
    }
}
