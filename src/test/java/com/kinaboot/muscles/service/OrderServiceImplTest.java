package com.kinaboot.muscles.service;

import com.kinaboot.muscles.TestConfigure;
import com.kinaboot.muscles.dao.OrderDao;
import com.kinaboot.muscles.dao.UserDao;
import com.kinaboot.muscles.domain.PointDto;
import com.kinaboot.muscles.handler.SearchCondition;
import org.checkerframework.checker.units.qual.C;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import java.util.Calendar;
import java.util.Date;

public class OrderServiceImplTest extends TestConfigure {
    @Autowired
    OrderService orderService;

    @Autowired
    OrderDao orderDao;

    @Autowired
    UserDao userDao;

    @Autowired
    UserService userService;

    @Test
    public void removeOrder() {
        int orderNo = 31;
        String cancelReason = "주문취소 테스트";
        String userId = orderDao.selectOrder(orderNo).getUserId();

        PointDto pointDto = userService.findPoint(orderNo);
        if(pointDto!=null){
            int point = userService.findPoint(orderNo).getPoint();
            // 1. 포인트 환불
            userDao.updateUserPoint(userId, -point, orderNo);
            // 2. 포인트 사용내역 삭제
            userDao.deleteUserPoint(orderNo);
        }
        // 쿠폰 사용 취소 처리
        userDao.updateCoupon(orderNo);

        // 주문 취소 처리
        orderDao.deleteOrder(orderNo, cancelReason);
    }

    @Test
    public void acceptOrder() {
    }

    @Test
    public void findOrderItems() {
    }

    @Test
    public void findOrder() {
        int orderNo=5;
        orderService.findOrder(orderNo);
    }

    @Test
    public void findOrderItem() {
        int orderNo = 16;
        int goodsNo = 3;
        orderService.findOrderItem(orderNo, goodsNo);
    }

    @Test
    public void findAllOrders() {
        SearchCondition sc = new SearchCondition();
        orderService.findAllOrders(sc);
    }

    @Test
    public void findOrders() {
    }

    @Test
    public void findOrderNo() {
    }

    @Test
    public void addOrder() {
    }
    @Test
    public void CalculateDate(){
        Calendar calendar = Calendar.getInstance();
        Date today = calendar.getTime();
        calendar.add(Calendar.DATE, -7);
        Date oneWeekAgo = calendar.getTime();
        System.out.println("오늘 날짜: " + today);
        System.out.println("1주일 전 날짜: " + oneWeekAgo);
    }
}