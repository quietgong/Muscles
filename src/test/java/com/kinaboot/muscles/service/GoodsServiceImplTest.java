package com.kinaboot.muscles.service;

import com.kinaboot.muscles.TestConfigure;
import com.kinaboot.muscles.dao.GoodsDao;
import com.kinaboot.muscles.dao.ReviewDao;
import com.kinaboot.muscles.domain.FaqDto;
import com.kinaboot.muscles.domain.GoodsDto;
import com.kinaboot.muscles.domain.GoodsImgDto;
import com.kinaboot.muscles.handler.SearchCondition;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

import static org.junit.Assert.*;

public class GoodsServiceImplTest extends TestConfigure {
    @Autowired
    GoodsService goodsService;
    @Autowired
    GoodsDao goodsDao;
    @Autowired
    ReviewDao reviewDao;

    @Test
    public void getBestGoods() {
        goodsService.findBestGoods();
    }

    @Test
    public void countByCategory() {
        SearchCondition sc = new SearchCondition();
        int totalCnt = goodsService.getTotalCntByCategory(sc);
        System.out.println("totalCnt = " + totalCnt);
    }

    @Test
    public void getByCategory() {
        SearchCondition sc = new SearchCondition();
        List<GoodsDto> goodsDtoList = goodsService.findGoods(sc);
        System.out.println("goodsDtoList = " + goodsDtoList);
    }

    @Test
    public void getGoodsImgList() {
        int goodsNo = 3;
        List<GoodsImgDto> imgDtoList = goodsService.getGoodsDetailImgList(goodsNo);
        System.out.println("imgDtoList = " + imgDtoList);
    }

    @Test
    public void getFaqList() {
        int goodsNo = 3;

        List<FaqDto> faqDtoList = goodsService.findFaqs(goodsNo);
        System.out.println("faqDtoList = " + faqDtoList);
    }

    @Test
    public void registerFaq() {
        FaqDto faqDto = new FaqDto("test1", 3, "질문 테스트", null);
        goodsService.addFaq(faqDto);
    }

    @Test
    public void removeGoods() {
        int goodsNo = 18;
        reviewDao.deleteGoodsReview(goodsNo); // 해당 상품에 대한 리뷰 데이터를 모두 삭제
        reviewDao.deleteGoodsFaq(goodsNo); // 해당 상품에 대한 문의 데이터를 모두 삭제
        goodsDao.deleteGoods(goodsNo);
    }
    @Test
    public void registerGoods(){
        GoodsDto goodsDto = new GoodsDto();
        int goodsNo = goodsDao.selectGoodsNo();
        goodsDto.setGoodsNo(goodsNo);

//        goodsService.saveGoodsImgs(goodsDto);
        goodsDao.insert(goodsDto);
    }
}