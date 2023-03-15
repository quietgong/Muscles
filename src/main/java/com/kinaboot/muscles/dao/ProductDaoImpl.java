package com.kinaboot.muscles.dao;

import com.kinaboot.muscles.domain.*;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class ProductDaoImpl implements ProductDao {
    @Autowired
    ProductDao productDao;
    @Autowired
    private SqlSession session;

    private static String namespace = "com.kinaboot.muscles.dao.productMapper.";

    @Override
    public int deleteProduct(Integer productNo) {
        return session.delete(namespace + "deleteProduct", productNo);
    }

    @Override
    public List<ProductImgDto> selectProductDetailImg(Integer productNo) {
        return session.selectList(namespace + "selectProductImg", productNo);
    }

    @Override
    public int updateProduct(ProductDto productDto) {
        productDto.setProductImgPath("/muscles/product/display?type=thumbnail&fileName=" + productDto.getProductImgPath());
        List<ProductImgDto> productImgDtoList = productDto.getProductImgDtoList();
        for(ProductImgDto productImgDto : productImgDtoList){
            Map map = new HashMap();
            map.put("productNo", productImgDto.getProductNo());
            map.put("filePath", "/muscles/product/display?type=detail&fileName=" +productImgDto.getUploadPath());
            session.insert(namespace + "insertProductImg", map);
        }
        return session.update(namespace + "updateProduct", productDto);
    }

    @Override
    public int insertFaq(FaqDto faqDto) {
        // faqAnswer이 null이면 질문에 insert, null이 아니면 답변에 insert
        return faqDto.getAnswer() == null ? session.insert(namespace + "insertFaqQuestion", faqDto) : session.insert(namespace + "insertFaqAnswer", faqDto);
    }

    @Override
    public List<FaqDto> selectFaqList(Integer productNo) {
        return session.selectList(namespace + "selectFaqList", productNo);
    }

    @Override
    public List<ProductDto> selectAll() {
        return session.selectList(namespace + "selectAll");
    }

    @Override
    public int selectByCategoryCnt(SearchCondition sc) {
        return session.selectOne(namespace + "selectByCategoryCnt", sc);
    }

    @Override
    public List<ProductDto> selectByCategory(SearchCondition sc) {
        return session.selectList(namespace + "selectByCategory", sc);
    }

    @Override
    public int insert(ProductDto productDto) {
        return session.insert(namespace + "insert", productDto);
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
    public ProductDto select(Integer productNo) {
        return session.selectOne(namespace + "select", productNo);
    }
}
