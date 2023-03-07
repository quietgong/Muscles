package com.kinaboot.muscles.dao;

import com.kinaboot.muscles.domain.DeliveryDto;
import com.kinaboot.muscles.domain.OrderDto;
import com.kinaboot.muscles.domain.PaymentDto;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class OrderDaoImpl implements OrderDao {
    @Autowired
    private SqlSession session;
    private static String namespace = "com.kinaboot.muscles.dao.orderMapper.";

    @Override
    public int updateStock(List<OrderDto> orderDtoList) {
        int rowCnt = 0;
        Map map = new HashMap();
        for (OrderDto orderDto :
                orderDtoList) {
            map.put("productNo", orderDto.getProductNo());
            map.put("productQty", orderDto.getProductQty());
            session.update(namespace + "updateStock", map);
            rowCnt++;
        }
        return rowCnt;
    }

    @Override
    public int insertOrder(String userId, List<OrderDto> orderDtoList, DeliveryDto deliveryDto, PaymentDto paymentDto) {
        Integer bundleNo = session.selectOne(namespace + "getBundleNo");
        bundleNo += 1;
        int rowCnt = 0;
        for (OrderDto orderDto : orderDtoList) {
            orderDto.setBundleNo(bundleNo);
            orderDto.setUserId(userId);
            rowCnt += session.insert(namespace + "insertProduct", orderDto);
        }
        deliveryDto.setBundleNo(bundleNo);
        rowCnt += session.insert(namespace + "insertDelivery", deliveryDto);

        paymentDto.setBundleNo(bundleNo);
        rowCnt += session.insert(namespace + "insertPayment", paymentDto);
        return rowCnt;
    }
}
