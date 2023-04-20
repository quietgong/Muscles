package com.kinaboot.muscles.service;

import com.kinaboot.muscles.TestConfigure;
import com.kinaboot.muscles.dao.GoodsDao;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import static org.junit.Assert.*;

public class GoodsServiceImplTest extends TestConfigure {
    @Autowired
    GoodsService goodsService;
    @Autowired
    GoodsDao goodsDao;

    @Before
    public void setUp() throws Exception {
        goodsDao.deleteAll();
    }

    @After
    public void tearDown() throws Exception {
        
    }

    @Test
    public void findBestGoods() {
    }

    @Test
    public void findAllGoods() {
    }

    @Test
    public void addGoods() {
    }

    @Test
    public void modifyGoods() {
    }

    @Test
    public void removeGoodsImg() {
    }

    @Test
    public void getGoodsDetailImgList() {
    }

    @Test
    public void findFaqs() {
    }

    @Test
    public void findAllCategories() {
    }

    @Test
    public void removeGoods() {
    }

    @Test
    public void addFaq() {
    }

    @Test
    public void findGoods() {
    }

    @Test
    public void getTotalCntByCategory() {
    }

    @Test
    public void testFindGoods() {
    }
}