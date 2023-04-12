package com.kinaboot.muscles.handler;

import com.kinaboot.muscles.dao.PostDao;
import com.kinaboot.muscles.domain.OrderDto;
import com.kinaboot.muscles.domain.PostDto;
import com.kinaboot.muscles.service.OrderService;
import com.kinaboot.muscles.service.GoodsService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
public class SearchConditionTest {
    @Autowired
    PostDao postDao;
    @Autowired
    GoodsService goodsService;
    @Autowired
    OrderService orderService;
    @Test
    public void searchResultCntTest() throws Exception {
        // title1 : 12
        SearchCondition sc = new SearchCondition(1, "t2");
        int totalCnt = goodsService.getTotalCntByCategory(sc);
        System.out.println("sc = " + sc);
        System.out.println("totalCnt = " + totalCnt);
    }
    @Test
    public void searchResultTest() throws Exception {
        // title1 : 12
        SearchCondition sc = new SearchCondition(1,"T", "title1");
        List<PostDto> list = postDao.searchResult(sc);
        System.out.println("list = " + list);
    }
    @Test
    public void dateConditionTest(){
        SearchCondition sc = new SearchCondition();
        List<OrderDto> orderDtoList = orderService.findAllOrders(sc);
        System.out.println("sc = " + sc);
        System.out.println("orderDtoList = " + orderDtoList);
    }

}