package com.kinaboot.muscles.service;

import com.kinaboot.muscles.dao.ProductDao;
import com.kinaboot.muscles.domain.FaqDto;
import com.kinaboot.muscles.domain.ProductDto;
import com.kinaboot.muscles.domain.ProductImgDto;
import com.kinaboot.muscles.handler.SearchCondition;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductServiceImpl implements ProductService{
    @Autowired
    ProductDao productDao;

    @Override
    public ProductDto getProduct(Integer productNo) {
        ProductDto productDto = productDao.select(productNo);
        productDto.setProductImgDtoList(productDao.selectProductDetailImg(productNo));
        return productDto;
    }

    @Override
    public List<ProductDto> getAllProduct() {
        return productDao.selectAll();
    }

    @Override
    public int modifyProduct(ProductDto productDto) {
        return productDao.updateProduct(productDto);
    }

    @Override
    public List<ProductImgDto> getProductDetailImgList(Integer productNo) {
        return productDao.selectProductDetailImg(productNo);
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
    public int getTotalCntByCategory(SearchCondition sc) {
        return productDao.selectByCategoryCnt(sc);
    }

    @Override
    public List<ProductDto> productList(SearchCondition sc) {
        return productDao.selectByCategory(sc);
    }
}
