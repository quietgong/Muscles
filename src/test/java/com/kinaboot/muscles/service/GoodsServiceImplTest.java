package com.kinaboot.muscles.service;

import com.kinaboot.muscles.TestConfigure;
import com.kinaboot.muscles.dao.GoodsDao;
import com.kinaboot.muscles.dao.ReviewDao;
import com.kinaboot.muscles.domain.*;
import com.kinaboot.muscles.handler.SearchCondition;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

import static org.junit.Assert.*;

public class GoodsServiceImplTest extends TestConfigure {
    @Autowired
    GoodsService goodsService;
    @Autowired
    GoodsDao goodsDao;
    @Autowired
    ReviewDao reviewDao;
    @Autowired
    ReviewService reviewService;

    @After
    public void tearDown(){
        goodsDao.deleteAllGoodsDetail(goodsDao.selectGoodsNo() - 1);
        goodsDao.deleteAll();
    }
    @Before
    public void setUp() {
        SearchCondition sc = new SearchCondition();
        sc.setCategory("유산소");
        sc.setSubCategory("런닝머신");

        GoodsDto goodsDto = new GoodsDto();
        goodsDto.setGoodsCategory("유산소");
        goodsDto.setGoodsCategoryDetail("런닝머신");
        goodsDto.setGoodsImgPath("thumbnail");

        goodsDao.insert(goodsDto);
//        goodsDao.insertGoodsImg(goodsDao.selectGoodsNo()-1,"detail");
        goodsDto.setGoodsImgDtoList(goodsDao.selectGoodsDetailImg(goodsDao.selectGoodsNo() - 1));
    }
    @Test
    public void findAllGoods() {
        int goodsCount = goodsDao.count();
        List<GoodsDto> goodsDtoList = goodsDao.selectAll();
        assertEquals(goodsCount, goodsDtoList.size());
    }
    @Test
    public void findFaqs() {
        int goodsNo = goodsDao.selectGoodsNo()-1;
        FaqDto faqDto1 = new FaqDto();
        FaqDto faqDto2 = new FaqDto();
        faqDto1.setGoodsNo(goodsNo);
        faqDto2.setGoodsNo(goodsNo);
        goodsDao.insertFaq(faqDto1);
        goodsDao.insertFaq(faqDto2);
        goodsDao.selectFaqList(goodsNo);
        assertEquals(goodsDao.selectFaqList(goodsNo).size(), 2);
    }
    @Test
    public void getGoodsDetailImgList() {
        int goodsNo = goodsDao.selectGoodsNo()-1;
        assertEquals(goodsDao.selectGoodsDetailImg(goodsNo).get(0).getUploadPath(), "detail");
    }
    @Test
    public void findAllCategories() {
        GoodsDto goodsDto = new GoodsDto();
        goodsDto.setGoodsCategory("근력");
        goodsDto.setGoodsCategoryDetail("바벨");
        goodsDao.insert(goodsDto);
        List<GoodsCategoryDto> goodsCategoryDtos = goodsDao.selectAllCategories();
        assertEquals(goodsCategoryDtos.get(0).getCategory(), "유산소");
        assertEquals(goodsCategoryDtos.get(0).getSubCategory(), "런닝머신");
        assertEquals(goodsCategoryDtos.get(1).getCategory(), "근력");
        assertEquals(goodsCategoryDtos.get(1).getSubCategory(), "바벨");
    }
    @Test
    public void removeGoods() {
        int goodsNo = goodsDao.selectGoodsNo();
        GoodsDto goodsDto = new GoodsDto();
        goodsDao.insert(goodsDto);
        ReviewDto reviewDto1 = new ReviewDto();
        ReviewDto reviewDto2 = new ReviewDto();
        reviewDto1.setGoodsNo(goodsNo);
        reviewDto2.setGoodsNo(goodsNo);
        reviewDao.insertReview(reviewDto1);
        reviewDao.insertReview(reviewDto2);
        FaqDto faqDto = new FaqDto();
        faqDto.setGoodsNo(goodsNo);
        goodsDao.insertFaq(faqDto);

        assertEquals(reviewDao.deleteGoodsReview(goodsNo),2); // 결과값 x 검증
        assertEquals(goodsDao.deleteGoodsFaq(goodsNo),1); // 결과값 y 검증
        assertEquals(goodsDao.deleteGoods(goodsNo),1); // 결과값 1 검증
    }
    @Test
    public void addFaq() {
        int goodsNo = goodsDao.selectGoodsNo() - 1;
        FaqDto faqDto = new FaqDto();
        faqDto.setGoodsNo(goodsNo);
        goodsDao.insertFaq(faqDto);
        assertEquals(goodsDao.selectFaqList(goodsNo).size(), 1);
    }
    @Test
    public void getTotalCntByCategory() {
        SearchCondition sc = new SearchCondition();
        sc.setCategory("유산소");
        sc.setSubCategory("런닝머신");
        int before = goodsDao.selectByCategoryCnt(sc);
        GoodsDto goodsDto = new GoodsDto();
        goodsDto.setGoodsCategory("유산소");
        goodsDto.setGoodsCategoryDetail("런닝머신");
        goodsDao.insert(goodsDto);
        assertEquals(before+1,goodsDao.selectByCategoryCnt(sc));
        // 결과값이 x개 인지 검증
    }
    @Test
    public void addGoods() {
        int goodsNo = goodsDao.selectGoodsNo() - 1;
        goodsDao.deleteAllGoodsDetail(goodsNo);
//        goodsDao.insertGoodsImg(goodsNo, "test/add");
        assertEquals(goodsDao.selectGoodsDetailImg(goodsNo).get(0).getUploadPath(),"test/add");
    }

    @Test
    public void modifyGoods() {
        int goodsNo = goodsDao.selectGoodsNo() - 1;
        GoodsDto goodsDto = goodsDao.select(goodsNo);
        goodsDao.deleteAllGoodsDetail(goodsNo);
        goodsDto.setGoodsImgDtoList(goodsDao.selectGoodsDetailImg(goodsNo));
        for(GoodsImgDto goodsImgDto : goodsDto.getGoodsImgDtoList())
//            goodsDao.insertGoodsImg(goodsNo, "modified");
        assertEquals(goodsDao.selectGoodsDetailImg(goodsNo).get(0).getUploadPath(), "modified");
    }

    @Test
    public void findGoods() {
        int goodsNo = goodsDao.selectGoodsNo() - 1;
        SearchCondition sc = new SearchCondition();
        sc.setCategory("유산소");
        sc.setSubCategory("런닝머신");
        List<GoodsDto> goodsDtoList = goodsDao.selectByCategory(sc);

        ReviewDto reviewDto = new ReviewDto();
        reviewDto.setGoodsNo(goodsNo);
        reviewDao.insertReview(reviewDto);
        for (GoodsDto goodsDto : goodsDtoList)
            goodsDto.setReviewDtoList(reviewDao.selectGoodsReview(goodsDto.getGoodsNo()));
        GoodsDto goodsDto = goodsDao.select(goodsNo);
        assertNotNull(String.valueOf(goodsDto.getGoodsReviewScore()), null);
    }

    @Test
    public void findBestGoods() {
        List<GoodsDto> goodsDtoList = goodsDao.selectBestGoods();
        for (GoodsDto goodsDto : goodsDtoList)
            goodsDto.setReviewDtoList(reviewDao.selectGoodsReview(goodsDto.getGoodsNo()));
    }
}