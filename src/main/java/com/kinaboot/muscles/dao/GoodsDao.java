package com.kinaboot.muscles.dao;

import com.kinaboot.muscles.domain.*;
import com.kinaboot.muscles.handler.SearchCondition;

import java.util.List;
import java.util.Map;

public interface GoodsDao {
    List<GoodsDto> selectByCategory(SearchCondition sc);

    int insert(GoodsDto goodsDto);

    int deleteAll();

    int count();

    GoodsDto select(Integer GoodsNo);

    List<GoodsDto> selectAll();

    int deleteGoods(Integer goodsNo);

    int updateGoods(GoodsDto goodsDto);

    List<FaqDto> selectFaqList(Integer goodsNo);

    int insertFaq(FaqDto faqDto);

    int selectByCategoryCnt(SearchCondition sc);

    List<GoodsImgDto> selectGoodsDetailImg(Integer goodsNo);

    List<GoodsCategoryDto> selectAllCategories();

    List<GoodsDto> selectBestGoods();

    int insertGoodsImg(GoodsImgDto goodsImgDto);

    int selectGoodsNo();

    int deleteAllGoodsDetail(Integer goodsNo);

    int deleteGoodsFaq(Integer goodsNo);
}
