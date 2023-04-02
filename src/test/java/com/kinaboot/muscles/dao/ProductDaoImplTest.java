package com.kinaboot.muscles.dao;

import com.kinaboot.muscles.domain.ProductDto;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
public class ProductDaoImplTest {
    @Autowired
    ProductDao productDao;
    @Test
    public void insertTest() throws Exception {
        deleteAll();

        for (int i = 0; i < 50; i++) {
            int randomPrice = (int) (Math.random() * 10000) + 90000;
            ProductDto productDto = new ProductDto
                    ("treadmil", "product" + i, randomPrice, 100);
            productDao.insert(productDto);
        }
    }

    @Test
    public void getProductByCategoryTest() throws Exception {
    }

    @Test
    public void updateProductTest() throws Exception {

    }

    @Test
    public void deleteProductTest() throws Exception {

    }

    @Test
    public void deleteAll() {
        productDao.deleteAll();
    }
}