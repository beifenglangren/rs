package edu.qtech.rs.dao;

import edu.qtech.rs.entity.ProductInfo;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.List;

import static org.junit.Assert.*;
@SpringBootTest
@RunWith(SpringRunner.class)
public class ProductDaoTest {
    @Autowired
    private ProductDao productDao;

    @Test
    public void select(){
        List<ProductInfo> productInfoList=productDao.selectByCidAndShopId(1,1);
        for(ProductInfo productInfo:productInfoList){
            System.out.println(productInfo.toString());
        }
    }
}