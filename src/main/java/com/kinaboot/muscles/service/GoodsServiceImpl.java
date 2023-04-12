package com.kinaboot.muscles.service;

import com.kinaboot.muscles.dao.GoodsDao;
import com.kinaboot.muscles.domain.FaqDto;
import com.kinaboot.muscles.domain.GoodsDto;
import com.kinaboot.muscles.domain.GoodsImgDto;
import com.kinaboot.muscles.handler.SearchCondition;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class GoodsServiceImpl implements GoodsService {
    @Autowired
    GoodsDao goodsDao;

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
    public int removeGoods(Integer GoodsNo) {
        return goodsDao.deleteGoods(GoodsNo);
    }

    @Override
    public int addFaq(FaqDto faqDto) {
        return goodsDao.insertFaq(faqDto);
    }

    @Override
    public GoodsDto findGoods(Integer GoodsNo) {
        GoodsDto goodsDto = goodsDao.select(GoodsNo);
        goodsDto.setGoodsImgDtoList(goodsDao.selectGoodsDetailImg(GoodsNo));
        return goodsDao.select(GoodsNo);
    }

    @Override
    public int getTotalCntByCategory(SearchCondition sc) {
        return goodsDao.selectByCategoryCnt(sc);
    }

    @Override
    public List<GoodsDto> findGoods(SearchCondition sc) {
        return goodsDao.selectByCategory(sc);
    }
}
