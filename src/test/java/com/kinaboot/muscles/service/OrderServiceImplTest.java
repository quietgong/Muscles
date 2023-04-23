package com.kinaboot.muscles.service;

import com.kinaboot.muscles.TestConfigure;
import com.kinaboot.muscles.dao.CartDao;
import com.kinaboot.muscles.dao.OrderDao;
import com.kinaboot.muscles.dao.UserDao;
import com.kinaboot.muscles.domain.*;
import com.kinaboot.muscles.handler.SearchCondition;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNull;

public class OrderServiceImplTest extends TestConfigure {
    @Autowired
    OrderService orderService;
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

    @Before
    public void setUp() throws Exception {
        orderDao.deleteAll();
        orderDao.deleteAllOrderItem();
        orderDao.deleteAllPayment();
        orderDao.deleteAllDelivery();
        userDao.deleteUserCoupon("test");
    }

    @Test
    public void 주문생성() {
        OrderDto orderDto = new OrderDto(1, 0, "test", null, "주문대기", null, null, null, null);
        String userId = orderDto.getUserId();

        List<OrderItemDto> orderItemDtos = new ArrayList<>();
        orderItemDtos.add(new OrderItemDto(1, 1, 1, 10000, "test", "test", "test", null, false));
        orderItemDtos.add(new OrderItemDto(1, 2, 2, 20000, "test", "test", "test", null, false));

        PaymentDto payment = new PaymentDto(1, 1, 30000, "네이버페이");

        DeliveryDto delivery = new DeliveryDto(1, 1, "test", null, null, null, null);

        orderDto.setOrderItemDtoList(orderItemDtos);
        orderDto.setPaymentDto(payment);
        orderDto.setDeliveryDto(delivery);

        // 주문 정보 생성
        int newOrderNo = orderDao.insertOrder(orderDto);
        orderDto.setOrderNo(newOrderNo);
        assertEquals(newOrderNo, orderDto.getOrderNo());

        List<OrderItemDto> orderItemDtoList = orderDto.getOrderItemDtoList();
        for (OrderItemDto orderItemDto : orderItemDtoList) {
            orderItemDto.setOrderNo(newOrderNo);
            // 주문상품 정보 생성
            orderDao.insertOrderItem(orderItemDto);
            // 주문상품 장바구니에서 제거
            cartDao.deleteCartItem(userId, orderItemDto.getGoodsNo());
        }
        assertEquals(cartDao.count("test"), 0);
        assertEquals(orderItemDtoList.get(0).getOrderNo(), newOrderNo);

        // 배송 정보 생성
        DeliveryDto deliveryDto = orderDto.getDeliveryDto();
        deliveryDto.setOrderNo(newOrderNo);
        orderDao.insertDelivery(deliveryDto);
        assertEquals(deliveryDto.getOrderNo(), newOrderNo);

        // 결제 정보 생성
        PaymentDto paymentDto = orderDto.getPaymentDto();
        paymentDto.setOrderNo(newOrderNo);
        orderDao.insertPayment(paymentDto);
        assertEquals(paymentDto.getOrderNo(), newOrderNo);
    }

    @Test
    public void 주문상품목록찾기() {
        int orderNo = 1;
        OrderItemDto orderItemDto1 = new OrderItemDto(1, 1, 1, 10000, "test", "test", "test", null, false);
        orderDao.insertOrderItem(orderItemDto1);
        OrderItemDto orderItemDto2 = new OrderItemDto(1, 2, 2, 20000, "test", "test", "test", null, false);
        orderDao.insertOrderItem(orderItemDto2);
        assertEquals(orderDao.selectOrderItemList(orderNo).size(), 2);
    }

    @Test
    public void 주문취소() {
        OrderDto orderDto = new OrderDto(1, 0, "test", null, "주문대기", null, null, null, null);
        orderDao.insertOrder(orderDto);

        String cancelReason = "testCancel";
        int orderNo = 1;
        userDao.updateUserPoint("test", 1000, 1);
        userDao.insertRecommendEventCoupon("test", "test");
        int couponNo = userDao.selectUserCoupon("test").get(0).getCouponNo();
        userDao.deleteCoupon(couponNo, 1);

        String userId = orderDao.selectOrder(orderNo).getUserId();
        // 포인트 사용 취소 처리
        PointDto pointDto = userService.findPoint(orderNo);
        if (pointDto != null) {
            int point = userService.findPoint(orderNo).getPoint();
            assertEquals(point,1000);
            // 1. 포인트 환불
            userDao.updateUserPoint(userId, -point, orderNo);
            // 2. 포인트 사용내역 삭제
            userDao.deleteUserPointHistory(orderNo);
            assertNull(userService.findPoint(orderNo));
            assertEquals(userDao.selectUserPoint("test").size(),0);
        }
        // 쿠폰 사용 취소 처리
        userDao.updateCoupon(orderNo);
        assertEquals(userService.findCoupons("test").get(0).getOrderNo(), 0);

        // 주문 취소 처리
        orderDao.deleteOrder(orderNo, cancelReason);
        OrderDto orderDto1 = orderDao.selectOrder(orderNo);
        assertEquals(orderDto1.getStatus(), "주문취소");
        assertEquals(orderDto1.getCancelReason(), "testCancel");
    }

    @Test
    public void 주문승인() {
        int orderNo = 1;

        // 구매 제품 재고 수량 변경
        List<OrderItemDto> orderItemDtoList = orderDao.selectOrderItemList(orderNo);
        for (OrderItemDto orderItemDto : orderItemDtoList) {
            orderDao.updateStock(orderItemDto);
        }
        // 포인트 적립
        OrderDto orderDto = orderService.findOrder(orderNo);
        String userId = orderDto.getUserId();

        // 적립 포인트 = 주문금액의 1%
        int pointPolicy = 1;
        int point = (int) (orderDto.getPaymentDto().getPrice() * 0.01 * pointPolicy);
        userDao.updateUserPoint(userId, point, orderNo);

        // 주문상태 변경
        orderDao.updateOrderStatus(orderNo);
    }


    @Test
    public void findOrder() {
        int orderNo = 1;

        OrderDto orderDto = orderDao.selectOrder(orderNo);
        List<OrderItemDto> orderItemDtoList = orderDao.selectOrderItemList(orderNo);
        DeliveryDto deliveryDto = orderDao.selectDelivery(orderNo);
        PaymentDto paymentDto = orderDao.selectPayment(orderNo);

        orderDto.setOrderItemDtoList(orderItemDtoList);
        orderDto.setDeliveryDto(deliveryDto);
        orderDto.setPaymentDto(paymentDto);
    }

    @Test
    public void findOrderItem() {
        orderDao.insertOrderItem(new OrderItemDto(1, 1, 1, 10000, "test1", "test", "test", null, false));
        orderDao.insertOrderItem(new OrderItemDto(2, 2, 1, 10000, "test2", "test", "test", null, false));
        int orderNo = 1;
        int goodsNo = 1;

        OrderItemDto orderItemDto = orderDao.selectOrderItem(orderNo, goodsNo);
        assertEquals(orderItemDto.getGoodsName(), "test1");
    }

    @Test
    public void findAllOrders() {
        SearchCondition sc = new SearchCondition();
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

        for (OrderDto orderDto : orderDtoList) {
            orderDto.setOrderItemDtoList(orderDao.selectOrderItemList(orderDto.getOrderNo()));
            orderDto.setDeliveryDto(orderDao.selectDelivery(orderDto.getOrderNo()));
            orderDto.setPaymentDto(orderDao.selectPayment(orderDto.getOrderNo()));
        }
        assertEquals(orderDtoList, 1);
    }

    @Test
    public void findOrders() {
        SearchCondition sc = new SearchCondition();
        List<OrderDto> orderDtoList = orderDao.selectAll(sc);
        for (OrderDto orderDto : orderDtoList) {
            for (OrderItemDto orderItemDto : orderDto.getOrderItemDtoList()) {
                ReviewDto reviewDto = reviewService.findReview(orderItemDto.getOrderNo(), orderItemDto.getGoodsNo());
                boolean hasReview = reviewDto != null;
                orderItemDto.setHasReview(hasReview);
            }
        }
    }
}