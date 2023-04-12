package com.kinaboot.muscles.dao;

import com.kinaboot.muscles.domain.CouponDto;
import com.kinaboot.muscles.domain.OrderDto;
import com.kinaboot.muscles.domain.PointDto;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
public class PointTest {
    @Autowired
    UserDao userDao;
    @Autowired
    OrderDao orderDao;
    @Test
    public void getPoint(){
        int orderNo=1;
        // 포인트 적립
        OrderDto orderDto = orderDao.selectOrder(orderNo);
        String userId = orderDto.getUserId();
        // 적립 포인트 = 주문금액의 1%
        int point = (int) (orderDto.getPaymentDto().getPrice()*0.01);

        System.out.println("userId = " + userId);
        System.out.println("point = " + point);
//        userDao.updateUserGetPoint(userId, point, orderNo);
//        // 주문상태 변경
//        orderDao.updateOrderStatus(orderNo);
    }
    @Test
    public void refundCouponPointTest(){
        int orderNo = 5;
        // 포인트 환불
//        userDao.updateUserPoint(orderNo);
        userDao.deleteUserPoint(orderNo);
        // 해당 주문에 쿠폰이 사용된 경우, 쿠폰 상태를 사용가능으로 변경
        userDao.updateUserCouponStatus(orderNo);
    }
}
