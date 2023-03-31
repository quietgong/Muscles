package com.kinaboot.muscles.dao;

import com.kinaboot.muscles.domain.OrderDto;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

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
}
