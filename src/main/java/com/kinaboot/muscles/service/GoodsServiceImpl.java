package com.kinaboot.muscles.service;

import com.kinaboot.muscles.dao.GoodsDao;
import com.kinaboot.muscles.dao.ReviewDao;
import com.kinaboot.muscles.domain.*;
import com.kinaboot.muscles.handler.SearchCondition;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class GoodsServiceImpl implements GoodsService {
    @Autowired
    GoodsDao goodsDao;
    @Autowired
    ReviewDao reviewDao;

    @Override
    public List<GoodsDto> findAllGoods() {
        return goodsDao.selectAll();
    }

    @Override
    public int modifyGoods(GoodsDto goodsDto) {
        return goodsDao.updateGoods(goodsDto);
    }

    @Override
    public List<GoodsImgDto> getGoodsDetailImgList(Integer GoodsNo) {
        return goodsDao.selectGoodsDetailImg(GoodsNo);
    }

    @Override
    public List<FaqDto> findFaqs(Integer GoodsNo) {
        return goodsDao.selectFaqList(GoodsNo);
    }

    @Override
    public List<GoodsCategoryDto> findAllCategories() {
        return goodsDao.selectAllCategories();
    }

    @Override
    public int removeGoods(Integer GoodsNo) {
        reviewDao.deleteGoodsReview(GoodsNo); // 해당 상품에 대한 리뷰 데이터를 모두 삭제
        reviewDao.deleteGoodsFaq(GoodsNo); // 해당 상품에 대한 문의 데이터를 모두 삭제
        return goodsDao.deleteGoods(GoodsNo);
    }

    @Override
    public int addFaq(FaqDto faqDto) {
        return goodsDao.insertFaq(faqDto);
    }

    @Override
    public GoodsDto findGoods(Integer GoodsNo) {
        GoodsDto goodsDto = goodsDao.select(GoodsNo);
        goodsDto.setReviewDtoList(reviewDao.selectGoodsReview(GoodsNo));
        goodsDto.setGoodsImgDtoList(goodsDao.selectGoodsDetailImg(GoodsNo));
        return goodsDto;
    }

    @Override
    public int getTotalCntByCategory(SearchCondition sc) {
        return goodsDao.selectByCategoryCnt(sc);
    }

    @Override
    public List<GoodsDto> findGoods(SearchCondition sc) {
        List<GoodsDto> goodsDtoList = goodsDao.selectByCategory(sc);
        for(GoodsDto goodsDto : goodsDtoList)
            goodsDto.setReviewDtoList(reviewDao.selectGoodsReview(goodsDto.getGoodsNo()));
        return goodsDtoList;
    }
}
