package com.kinaboot.muscles.service;

import com.kinaboot.muscles.TestConfigure;
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

    @Test
    public void countByCategory(){
        SearchCondition sc = new SearchCondition();
        int totalCnt = goodsService.getTotalCntByCategory(sc);
        System.out.println("totalCnt = " + totalCnt);
    }
    @Test
    public void getByCategory(){
        SearchCondition sc = new SearchCondition();
        List<GoodsDto> goodsDtoList = goodsService.findGoods(sc);
        System.out.println("goodsDtoList = " + goodsDtoList);
    }
    @Test
    public void getGoodsImgList(){
        int goodsNo = 3;
        List<GoodsImgDto> imgDtoList = goodsService.getGoodsDetailImgList(goodsNo);
        System.out.println("imgDtoList = " + imgDtoList);
    }
    @Test
    public void getFaqList(){
        int goodsNo = 3;

        List<FaqDto> faqDtoList = goodsService.findFaqs(goodsNo);
        System.out.println("faqDtoList = " + faqDtoList);
    }

}