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
    public List<ProductDto> findAllProduct() {
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
    public List<FaqDto> findFaqs(Integer productNo) {
        return productDao.selectFaqList(productNo);
    }

    @Override
    public int removeProduct(Integer productNo) {
        return productDao.deleteProduct(productNo);
    }

    @Override
    public int addFaq(FaqDto faqDto) {
        return productDao.insertFaq(faqDto);
    }

    @Override
    public ProductDto findProduct(Integer productNo) {
        ProductDto productDto = productDao.select(productNo);
        productDto.setProductImgDtoList(productDao.selectProductDetailImg(productNo));
        return productDao.select(productNo);
    }

    @Override
    public int getTotalCntByCategory(SearchCondition sc) {
        return productDao.selectByCategoryCnt(sc);
    }

    @Override
    public List<ProductDto> findProducts(SearchCondition sc) {
        return productDao.selectByCategory(sc);
    }
}
