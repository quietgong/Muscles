package com.kinaboot.muscles.dao;

import com.kinaboot.muscles.domain.DeliveryDto;
import com.kinaboot.muscles.domain.OrderDto;
import com.kinaboot.muscles.domain.PaymentDto;
import com.kinaboot.muscles.service.OrderService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.ArrayList;
import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
public class OrderDaoImplTest {
    @Autowired
    OrderService orderService;
    @Test
    public void orderInsertTest(){
        String userId = "testId";
        List<OrderDto> orderDtoList = new ArrayList<>();
        orderDtoList.add(new OrderDto("오준호",1,10));
        orderDtoList.add(new OrderDto("오준호",2,20));
        orderDtoList.add(new OrderDto("오준호",3,30));

        DeliveryDto deliveryDto = new DeliveryDto("오준호","01012345678","청주시","메세지 테스트");
        PaymentDto paymentDto = new PaymentDto(25000,"네이버페이");

        orderService.saveOrder(userId, orderDtoList, deliveryDto, paymentDto);

    }
}
