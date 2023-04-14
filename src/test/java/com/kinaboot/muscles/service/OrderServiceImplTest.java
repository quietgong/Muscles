package com.kinaboot.muscles.service;

import com.kinaboot.muscles.TestConfigure;
import com.kinaboot.muscles.handler.SearchCondition;
import org.checkerframework.checker.units.qual.C;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import java.util.Calendar;
import java.util.Date;

public class OrderServiceImplTest extends TestConfigure {
    @Autowired
    OrderService orderService;

    @Test
    public void removeOrder() {

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