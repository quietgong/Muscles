package com.kinaboot.muscles.dao;

import com.kinaboot.muscles.domain.*;
import com.kinaboot.muscles.handler.SearchCondition;

import java.util.List;

public interface GoodsDao {
    List<GoodsDto> selectByCategory(SearchCondition sc);
    int insert(GoodsDto goodsDto);
    int deleteAll();
    int count();

    GoodsDto select(Integer GoodsNo);

    List<GoodsDto> selectAll();

    int deleteGoods(Integer GoodsNo);

    int updateGoods(GoodsDto goodsDto);

    List<FaqDto> selectFaqList(Integer GoodsNo);

    int insertFaq(FaqDto faqDto);

    int selectByCategoryCnt(SearchCondition sc);

    List<GoodsImgDto> selectGoodsDetailImg(Integer GoodsNo);

    List<GoodsCategoryDto> selectAllCategories();
}
