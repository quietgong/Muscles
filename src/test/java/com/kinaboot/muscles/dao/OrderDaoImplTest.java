package com.kinaboot.muscles.dao;

import com.kinaboot.muscles.domain.*;
import com.kinaboot.muscles.service.OrderService;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
public class OrderDaoImplTest {
    @Autowired
    OrderService orderService;
    @Autowired
    OrderDao orderDao;
    @Autowired
    private SqlSession session;
    private static String namespace = "com.kinaboot.muscles.dao.orderMapper.";
    @Test
    public void updateStock() {
        Map map = new HashMap();
        map.put("productNo", 3);
        map.put("productQty", 10);
        session.update(namespace + "updateStock", map);
    }

    @Test
    public void selectAll() {
        // userId별 주문목록 가져오기
        String userId = "test7";
        List<OrderDto> orderDtoList = session.selectList(namespace + "selectOrderList", userId);
        System.out.println("orderDtoList = " + orderDtoList);
        for (OrderDto orderDto : orderDtoList) {
            // 해당 주문정보의 orderNo를 통해 주문상품 정보, 배송정보, 결제정보를 가져온다.
            int orderNo = orderDto.getOrderNo();
            orderDto.setOrderItemDtoList(session.selectList(namespace + "selectOrderItemList", orderNo));
            orderDto.setDeliveryDto(session.selectOne(namespace + "selectDelivery", orderNo));
            orderDto.setPaymentDto(session.selectOne(namespace + "selectPayment", orderNo));
        }
        System.out.println("orderDtoList = " + orderDtoList);
    }

    @Test
    public void getOrderTest() {
        String userId = "test8";
        List<OrderDto> orderDtoList = orderService.getOrderList(userId);
        System.out.println("orderDtoList = " + orderDtoList);
    }

    @Test
    public void getRecentOrder(){
        OrderDto orderDto = new OrderDto();
        orderDto.setOrderNo(orderService.getUserRecentOrderNo());
        System.out.println("orderDto.getOrderNo() = " + orderDto.getOrderNo());
    }

    @Test
    public void getOrderDetail(){
        int orderNo = 25;
        OrderDto orderDto = session.selectOne(namespace + "selectOrder", orderNo);
        System.out.println("orderDto = " + orderDto);
        List<OrderItemDto> orderItemDtoList = session.selectList(namespace + "selectOrderItemList", orderNo);
        System.out.println("orderItemDtoList = " + orderItemDtoList);
        DeliveryDto deliveryDto = session.selectOne(namespace + "selectDelivery", orderNo);
        System.out.println("deliveryDto = " + deliveryDto);
        PaymentDto paymentDto = session.selectOne(namespace + "selectPayment", orderNo);
        System.out.println("paymentDto = " + paymentDto);
        orderDto.setOrderItemDtoList(orderItemDtoList);
        orderDto.setDeliveryDto(deliveryDto);
        orderDto.setPaymentDto(paymentDto);
    }

}
