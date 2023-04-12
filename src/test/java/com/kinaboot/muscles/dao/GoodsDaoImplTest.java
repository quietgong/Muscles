package com.kinaboot.muscles.dao;

import com.kinaboot.muscles.domain.GoodsDto;
import com.kinaboot.muscles.service.GoodsService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
public class GoodsDaoImplTest {
    @Autowired
    GoodsDao goodsDao;
    @Autowired
    GoodsService goodsService;
    @Test
    public void getProduct(){
        goodsService.findGoods(3);
    }
    @Test
    public void insertTest() throws Exception {
        deleteAll();

        for (int i = 0; i < 50; i++) {
            int randomPrice = (int) (Math.random() * 10000) + 90000;
            GoodsDto goodsDto = new GoodsDto
                    ("treadmil", "product" + i, randomPrice, 100);
            goodsDao.insert(goodsDto);
        }
    }

    @Test
    public void getProductByCategoryTest() throws Exception {
    }

    @Test
    public void updateProductTest() throws Exception {

    }

    @Test
    public void deleteProductTest() throws Exception {

    }

    @Test
    public void deleteAll() {
        goodsDao.deleteAll();
    }
}