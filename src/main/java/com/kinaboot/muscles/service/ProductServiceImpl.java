package com.kinaboot.muscles.service;

import com.kinaboot.muscles.dao.ProductDao;
import com.kinaboot.muscles.domain.FaqDto;
import com.kinaboot.muscles.domain.ProductDto;
import com.kinaboot.muscles.domain.SearchCondition;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductServiceImpl implements ProductService{
    @Autowired
    ProductDao productDao;

    @Override
    public List<ProductDto> getAllProduct() {
        return productDao.selectAll();
    }

    @Override
    public int modifyProduct(ProductDto productDto) {
        return productDao.updateProduct(productDto);
    }

    @Override
    public List<FaqDto> getFaqList(Integer productNo) {
        return productDao.selectFaqList(productNo);
    }

    @Override
    public int removeProduct(Integer productNo) {
        return productDao.deleteProduct(productNo);
    }

    @Override
    public int registerFaq(FaqDto faqDto) {
        return productDao.insertFaq(faqDto);
    }

    @Override
    public ProductDto getProductByNo(Integer productNo) {
        return productDao.select(productNo);
    }

    @Override
    public int getTotalCntByCategory(String category) {
        return productDao.selectByCategoryCnt(category);
    }

    @Override
    public List<ProductDto> productList(String category, SearchCondition sc) {
        return productDao.selectByCategory(category, sc);
    }
}
