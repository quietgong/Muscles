package com.kinaboot.muscles.domain;

import com.kinaboot.muscles.service.ProductService;
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
    ProductService productService;
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
        int totalCnt = productService.getTotalCntByCategory(sc);
        List<ProductDto> productDtoList = calculateReviewScore(productService.productList(sc));
        System.out.println("productDtoList = " + productDtoList);

    }
    public List<ProductDto> calculateReviewScore(List<ProductDto> productDtoList) {
        for(ProductDto productDto : productDtoList){
            List<ReviewDto> reviewDtoList = reviewService.getReviewListByProductNo(productDto.getProductNo());
            double productScore=0.0;
            for(ReviewDto reviewDto : reviewDtoList)
                productScore += reviewDto.getScore();
            productScore = productScore / reviewDtoList.size();
            productDto.setProductReviewScore(productScore);
            productDto.setReviewDtoList(reviewDtoList);
        }
        return productDtoList;
    }
}