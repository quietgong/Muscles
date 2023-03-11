package com.kinaboot.muscles.dao;

import com.kinaboot.muscles.domain.ProductDto;
import com.kinaboot.muscles.domain.UserDto;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

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
    public int updateProduct(ProductDto productDto) {
        return session.update(namespace + "updateProduct", productDto);
    }

    @Override
    public List<ProductDto> selectAll() {
        return session.selectList(namespace + "selectAll");
    }

    @Override
    public List<ProductDto> selectByCategory(String category) {
        return session.selectList(namespace + "selectByCategory", category);
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
