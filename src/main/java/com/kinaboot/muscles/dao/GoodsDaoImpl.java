package com.kinaboot.muscles.dao;

import com.kinaboot.muscles.domain.*;
import com.kinaboot.muscles.handler.SearchCondition;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class GoodsDaoImpl implements GoodsDao {
    @Autowired
    GoodsDao goodsDao;
    @Autowired
    private SqlSession session;

    private static String namespace = "com.kinaboot.muscles.dao.goodsMapper.";

    @Override
    public int selectGoodsNo() {
        return session.selectOne(namespace + "selectGoodsNo");
    }

    @Override
    public List<GoodsDto> selectBestGoods() {
        return session.selectList(namespace + "selectBestGoods");
    }

    @Override
    public int deleteGoods(Integer GoodsNo) {
        return session.delete(namespace + "deleteGoods", GoodsNo);
    }

    @Override
    public List<GoodsImgDto> selectGoodsDetailImg(Integer GoodsNo) {
        return session.selectList(namespace + "selectGoodsImg", GoodsNo);
    }

    @Override
    public int updateGoods(GoodsDto goodsDto) {
        return session.update(namespace + "updateGoods", goodsDto);
    }

    @Override
    public int insertFaq(FaqDto faqDto) {
        // faqAnswer이 null이면 질문에 insert, null이 아니면 답변에 insert
        return faqDto.getAnswer() == null ? session.insert(namespace + "insertFaqQuestion", faqDto) : session.insert(namespace + "insertFaqAnswer", faqDto);
    }

    @Override
    public List<FaqDto> selectFaqList(Integer GoodsNo) {
        return session.selectList(namespace + "selectFaqList", GoodsNo);
    }

    @Override
    public List<GoodsCategoryDto> selectAllCategories() {
        return session.selectList(namespace + "selectAllCategories");
    }

    @Override
    public List<GoodsDto> selectAll() {
        return session.selectList(namespace + "selectAll");
    }

    @Override
    public int selectByCategoryCnt(SearchCondition sc) {
        return session.selectOne(namespace + "selectByCategoryCnt", sc);
    }

    @Override
    public List<GoodsDto> selectByCategory(SearchCondition sc) {
        return session.selectList(namespace + "selectByCategory", sc);
    }

    @Override
    public int insert(GoodsDto goodsDto) {
        return session.insert(namespace + "insert", goodsDto);
    }

    @Override
    public int insertGoodsImg(Map<String, String> map) {
        return session.insert(namespace + "insertGoodsImg", map);
    }

    @Override
    public int deleteAll() {
        return session.delete(namespace + "deleteAll");
    }

    @Override
    public int count() {
        return session.selectOne(namespace + "count");
    }

    @Override
    public GoodsDto select(Integer GoodsNo) {
        return session.selectOne(namespace + "select", GoodsNo);
    }

    @Override
    public int deleteGoodsThumbnail(String imgPath) {
        return session.delete(namespace + "deleteGoodsThumbnail", imgPath);
    }

    @Override
    public int deleteGoodsDetail(String imgPath) {
        return session.delete(namespace + "deleteGoodsDetail", imgPath);
    }
    @Override
    public int deleteAllGoodsDetail(int goodsNo) {
        return session.delete(namespace + "deleteAllGoodsDetail", goodsNo);
    }
}
