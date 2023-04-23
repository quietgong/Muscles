package com.kinaboot.muscles.dao;

import com.kinaboot.muscles.TestConfigure;
import com.kinaboot.muscles.domain.GoodsDto;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import static org.junit.Assert.*;

public class GoodsDaoImplTest extends TestConfigure {
    @Autowired
    GoodsDao goodsDao;

    @Test
    public void insert() {
        GoodsDto goodsDto = new GoodsDto();
        goodsDto.setGoodsCategory("유산소");
        goodsDto.setGoodsCategoryDetail("런닝머신");
        goodsDto.setGoodsName("런닝머신");
        goodsDto.setGoodsPrice(55000);
        goodsDao.insert(goodsDto);
    }
}