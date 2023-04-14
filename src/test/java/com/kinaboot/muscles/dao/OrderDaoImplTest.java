package com.kinaboot.muscles.dao;

import com.kinaboot.muscles.TestConfigure;
import com.kinaboot.muscles.domain.*;
import com.kinaboot.muscles.handler.SearchCondition;
import com.kinaboot.muscles.service.OrderService;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class OrderDaoImplTest extends TestConfigure {
    @Autowired
    OrderService orderService;
    @Autowired
    OrderDao orderDao;
    @Autowired
    private SqlSession session;
    private static String namespace = "com.kinaboot.muscles.dao.orderMapper.";
    @Test
    public void updateStock() {
        // 초기 재고
        Map map = new HashMap();
        map.put("productNo", 3);
        map.put("productQty", 10);
        session.update(namespace + "updateStock", map);
        // 변경 재고
    }

    @Test
    public void selectAll() {
        // userId별 주문목록 가져오기
        String userId = "test7";
        List<OrderDto> orderDtoList = session.selectList(namespace + "selectOrderList", userId);
        for (OrderDto orderDto : orderDtoList) {
            // 해당 주문정보의 orderNo를 통해 주문상품 정보, 배송정보, 결제정보를 가져온다.
            int orderNo = orderDto.getOrderNo();
            orderDto.setOrderItemDtoList(session.selectList(namespace + "selectOrderItemList", orderNo));
            orderDto.setDeliveryDto(session.selectOne(namespace + "selectDelivery", orderNo));
            orderDto.setPaymentDto(session.selectOne(namespace + "selectPayment", orderNo));
        }
    }

    @Test
    public void getOrderTest() {
        String userId = "test8";
    }

    @Test
    public void getRecentOrder(){
        OrderDto orderDto = new OrderDto();
    }

    @Test
    public void getOrderDetail(){
        int orderNo = 25;
        OrderDto orderDto = session.selectOne(namespace + "selectOrder", orderNo);
        List<OrderItemDto> orderItemDtoList = session.selectList(namespace + "selectOrderItemList", orderNo);
        DeliveryDto deliveryDto = session.selectOne(namespace + "selectDelivery", orderNo);
        PaymentDto paymentDto = session.selectOne(namespace + "selectPayment", orderNo);
        orderDto.setOrderItemDtoList(orderItemDtoList);
        orderDto.setDeliveryDto(deliveryDto);
        orderDto.setPaymentDto(paymentDto);
    }
    @Test
    public void getOrder(){
        Date today = new Date();
        SearchCondition sc = new SearchCondition();
        System.out.println("sc = " + sc);
        orderDao.selectAll("test1", sc);
    }

    @Test
    public void getOrderAll(){
        Date today = new Date();
        SearchCondition sc = new SearchCondition(null, today);
        System.out.println("sc = " + sc);
        orderService.findAllOrders(sc);
    }
    @Test
    public void removeOrderAll(){
    }
}
