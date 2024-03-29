package com.kinaboot.muscles.dao;

import com.kinaboot.muscles.domain.*;
import com.kinaboot.muscles.handler.SearchCondition;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class GoodsDaoImpl implements GoodsDao {

    public GoodsDaoImpl(SqlSession session) {
        this.session = session;
    }

    private final SqlSession session;

    private static final String namespace = "com.kinaboot.muscles.dao.goodsMapper.";

    @Override
    public int count() {
        return session.selectOne(namespace + "count");
    }

    @Override
    public int selectGoodsNo() {
        return session.selectOne(namespace + "selectGoodsNo");
    }

    @Override
    public List<GoodsDto> selectBestGoods() {
        return session.selectList(namespace + "selectBestGoods");
    }

    @Override
    public List<GoodsDto> selectAll() {
        return session.selectList(namespace + "selectAll");
    }

    @Override
    public GoodsDto select(Integer goodsNo) {
        return session.selectOne(namespace + "select", goodsNo);
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
    public List<FaqDto> selectFaqList(Integer goodsNo) {
        return session.selectList(namespace + "selectFaqList", goodsNo);
    }

    @Override
    public List<GoodsCategoryDto> selectAllCategories() {
        return session.selectList(namespace + "selectAllCategories");
    }

    @Override
    public List<GoodsImgDto> selectGoodsDetailImg(Integer goodsNo) {
        return session.selectList(namespace + "selectGoodsImg", goodsNo);
    }

    @Override
    public int insert(GoodsDto goodsDto) {
        return session.insert(namespace + "insert", goodsDto);
    }

    @Override
    public int insertGoodsImg(GoodsImgDto goodsImgDto) {
        return session.insert(namespace + "insertGoodsImg", goodsImgDto);
    }

    @Override
    public int insertFaq(FaqDto faqDto) { // Answer이 null이면 질문에 insert, null이 아니면 답변에 insert
        return faqDto.getAnswer() == null ? session.insert(namespace + "insertFaqQuestion", faqDto) : session.insert(namespace + "insertFaqAnswer", faqDto);
    }

    @Override
    public int updateGoods(GoodsDto goodsDto) {
        return session.update(namespace + "updateGoods", goodsDto);
    }

    @Override
    public int deleteGoods(Integer goodsNo) {
        return session.delete(namespace + "deleteGoods", goodsNo);
    }

    @Override
    public int deleteGoodsFaq(Integer goodsNo) {
        return session.delete(namespace + "deleteGoodsFaq", goodsNo);
    }

    @Override
    public int deleteAllGoodsDetail(Integer goodsNo) {
        return session.delete(namespace + "deleteAllGoodsDetail", goodsNo);
    }

    @Override
    public int deleteAll() {
        return session.delete(namespace + "deleteAll");
    }
}
