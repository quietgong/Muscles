package com.kinaboot.muscles.service;

import com.kinaboot.muscles.domain.FaqDto;
import com.kinaboot.muscles.domain.GoodsDto;
import com.kinaboot.muscles.domain.GoodsImgDto;
import com.kinaboot.muscles.domain.GoodsCategoryDto;
import com.kinaboot.muscles.handler.SearchCondition;

import java.util.List;

public interface GoodsService {
    List<GoodsDto> findAllGoods();

    List<GoodsDto> findGoods(SearchCondition sc);

    GoodsDto findGoods(Integer GoodsNo);

    int removeGoods(Integer GoodsNo);

    int modifyGoods(GoodsDto goodsDto);

    List<FaqDto> findFaqs(Integer GoodsNo);

    int addFaq(FaqDto faqDto);

    int getTotalCntByCategory(SearchCondition sc);

    List<GoodsCategoryDto> findAllCategories();

    List<GoodsDto> findBestGoods();

    void addGoods(GoodsDto goodsDto);
}
