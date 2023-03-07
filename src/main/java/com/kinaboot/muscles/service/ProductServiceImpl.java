package com.kinaboot.muscles.service;

import com.kinaboot.muscles.dao.ProductDao;
import com.kinaboot.muscles.domain.ProductDto;
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
    public ProductDto getProductByNo(Integer productNo) {
        return productDao.select(productNo);
    }

    @Override
    public List<ProductDto> productList(String category) {
        return productDao.selectByCategory(category);
    }
}
