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
import java.util.Calendar;
import java.util.Date;
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
    @Autowired
    ReviewService reviewService;

    @Override
    public int removeOrder(int orderNo, String cancelReason) {
        String userId = orderDao.selectOrder(orderNo).getUserId();

        // 포인트 사용 취소 처리
        PointDto pointDto = userService.findPoint(orderNo);
        if (pointDto != null) {
            int point = userService.findPoint(orderNo).getPoint();
            // 1. 포인트 환불
            userDao.updateUserPoint(userId, -point, orderNo);
            // 2. 포인트 사용내역 삭제
            userDao.deleteUserPoint(orderNo);
        }
        // 쿠폰 사용 취소 처리
        userDao.updateCoupon(orderNo);

        // 주문 취소 처리
        return orderDao.deleteOrder(orderNo, cancelReason);
    }

    @Override
    public int acceptOrder(int orderNo) {
        // 구매 제품 재고 수량 변경
        List<OrderItemDto> orderItemDtoList = orderDao.selectOrderItemList(orderNo);
        for (OrderItemDto orderItemDto : orderItemDtoList) {
            orderDao.updateStock(orderItemDto);
        }

        // 포인트 적립
        OrderDto orderDto = findOrder(orderNo);
        String userId = orderDto.getUserId();

        // 적립 포인트 = 주문금액의 1%
        int pointPolicy = 1;
        int point = (int) (orderDto.getPaymentDto().getPrice() * 0.01 * pointPolicy);
        userDao.updateUserPoint(userId, point, orderNo);

        // 주문상태 변경
        return orderDao.updateOrderStatus(orderNo);
    }

    @Override
    public List<OrderItemDto> findOrderItems(Integer orderNo) {
        return orderDao.selectOrderItemList(orderNo);
    }

    @Override
    public OrderDto findOrder(Integer orderNo) {
        OrderDto orderDto = orderDao.selectOrder(orderNo);
        List<OrderItemDto> orderItemDtoList = orderDao.selectOrderItemList(orderNo);
        DeliveryDto deliveryDto = orderDao.selectDelivery(orderNo);
        PaymentDto paymentDto = orderDao.selectPayment(orderNo);

        orderDto.setOrderItemDtoList(orderItemDtoList);
        orderDto.setDeliveryDto(deliveryDto);
        orderDto.setPaymentDto(paymentDto);

        return orderDto;
    }

    @Override
    public OrderItemDto findOrderItem(Integer orderNo, Integer goodsNo) {
        return orderDao.selectOrderItem(orderNo, goodsNo);
    }

    @Override
    public List<OrderDto> findAllOrders(SearchCondition sc) {
        String option = sc.getPeriod();
        Calendar calendar = Calendar.getInstance();
        Date today = calendar.getTime();
        sc.setEndDate(today); // 종료 날짜는 현재를 기준

        if (option.equals("week")) // 이번주
            calendar.add(Calendar.DATE, -7);
        else if (option.equals("month")) // 이번달
            calendar.add(Calendar.MONTH, -1);
        else if (option.equals("3months")) // 지난 3개월
            calendar.add(Calendar.MONTH, -3);

        if (!(option.equals("all") || option.equals("")))
            sc.setStartDate(calendar.getTime()); // 시작 날짜
        List<OrderDto> orderDtoList = orderDao.selectOrderAll(sc);
        return getOrderDetail(orderDtoList);
    }

    @Override
    public List<OrderDto> findOrders(SearchCondition sc) {
        List<OrderDto> orderDtoList = orderDao.selectAll(sc);
        return verifyReviewExist(getOrderDetail(orderDtoList));
    }

    private List<OrderDto> verifyReviewExist(List<OrderDto> orderDtoList) {
        for (OrderDto orderDto : orderDtoList) {
            for (OrderItemDto orderItemDto : orderDto.getOrderItemDtoList()) {
                ReviewDto reviewDto = reviewService.findReview(orderItemDto.getOrderNo(), orderItemDto.getGoodsNo());
                boolean hasReview = reviewDto != null;
                orderItemDto.setHasReview(hasReview);
            }
        }
        return orderDtoList;
    }

    @Override
    public OrderDto addOrder(String orderData, int couponNo, int point) {
        OrderDto orderDto = null;
        try {
            orderDto = JsonToJava(orderData);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
        String userId = orderDto.getUserId();

        // 주문 정보 생성
        int newOrderNo = orderDao.insertOrder(orderDto);
        orderDto.setOrderNo(newOrderNo);

        List<OrderItemDto> orderItemDtoList = orderDto.getOrderItemDtoList();
        for(OrderItemDto orderItemDto : orderItemDtoList){
            orderItemDto.setOrderNo(newOrderNo);
            // 주문상품 정보 생성
            orderDao.insertOrderItem(orderItemDto);
            // 주문상품 장바구니에서 제거
            cartDao.deleteCartItem(userId, orderItemDto.getGoodsNo());
        }

        // 배송 정보 생성
        DeliveryDto deliveryDto = orderDto.getDeliveryDto();
        deliveryDto.setOrderNo(newOrderNo);
        orderDao.insertDelivery(deliveryDto);

        // 결제 정보 생성
        PaymentDto paymentDto = orderDto.getPaymentDto();
        paymentDto.setOrderNo(newOrderNo);
        orderDao.insertPayment(paymentDto);

        // 쿠폰 상태 변경
        if (couponNo != 0) userService.removeCoupon(couponNo, newOrderNo);

        // 포인트 사용 적용
        if (point != 0) userService.modifyPoint(userId, -point, newOrderNo);

        return findOrder(newOrderNo);
    }

    private List<OrderDto> getOrderDetail(List<OrderDto> orderDtoList) {
        for (OrderDto orderDto : orderDtoList) {
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
