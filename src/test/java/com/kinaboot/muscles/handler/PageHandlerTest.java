package com.kinaboot.muscles.handler;

import com.kinaboot.muscles.domain.GoodsDto;
import com.kinaboot.muscles.domain.ReviewDto;
import com.kinaboot.muscles.service.GoodsService;
import com.kinaboot.muscles.service.ReviewService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
public class PageHandlerTest {
    @Autowired
    GoodsService goodsService;
    @Autowired
    ReviewService reviewService;
    @Test
    public void totalPageTest() {
        SearchCondition sc = new SearchCondition();
        PageHandler ph = new PageHandler(140, sc);
        ph.print();
        System.out.println("ph = " + ph);
        assert (ph.getTotalPage() == 14);
    }

    @Test
    public void productListPagingTest() {
        SearchCondition sc = new SearchCondition(1,"lowPrice","");
        String category = "cardio";
        int totalCnt = goodsService.getTotalCntByCategory(sc);
        List<GoodsDto> goodsDtoList = calculateReviewScore(goodsService.findGoods(sc));
        System.out.println("productDtoList = " + goodsDtoList);

    }
    public List<GoodsDto> calculateReviewScore(List<GoodsDto> goodsDtoList) {
        for(GoodsDto goodsDto : goodsDtoList){
            List<ReviewDto> reviewDtoList = reviewService.findReviews(goodsDto.getGoodsNo());
            double productScore=0.0;
            for(ReviewDto reviewDto : reviewDtoList)
                productScore += reviewDto.getScore();
            productScore = productScore / reviewDtoList.size();
            goodsDto.setGoodsReviewScore(productScore);
            goodsDto.setReviewDtoList(reviewDtoList);
        }
        return goodsDtoList;
    }
}