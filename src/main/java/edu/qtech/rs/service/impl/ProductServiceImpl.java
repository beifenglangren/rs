package edu.qtech.rs.service.impl;

import edu.qtech.rs.dao.ProductDao;
import edu.qtech.rs.entity.ProductInfo;
import edu.qtech.rs.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class ProductServiceImpl implements ProductService {
    @Autowired
    private ProductDao productDao;
    @Override
    public List<ProductInfo> findByName(String name,Integer shopId) {
        return productDao.selectByName(name,shopId);
    }

    @Override
    public List<ProductInfo> findByShopId(Integer id) {
        return productDao.selectByShopId(id);
    }

    @Override
    public List<ProductInfo> findByCidAndShopId(Integer cid, Integer sid) {
        return productDao.selectByCidAndShopId(cid,sid);
    }

    @Override
    public void update(ProductInfo productInfo) {
        productDao.update(productInfo);
    }

    @Override
    public ProductInfo findById(Integer id) {
        return productDao.selectById(id);
    }

    @Override
    public List<ProductInfo> findOftenBuy(Integer id) {
        return productDao.selectOftenBuy(id);
    }

    @Override
    public void add(ProductInfo productInfo) {
        productDao.insert(productInfo);
    }

    @Override
    public List<ProductInfo> findByOnlyName(String name, Integer shopId) {
        return productDao.selectByOnlyName(name, shopId);
    }

    @Override
    public ProductInfo findByEditName(String name, Integer shopId, Integer productId) {
        return productDao.selectByEditName(name, shopId, productId);
    }

    @Override
    public void remove(Integer id) {
        productDao.delete(id);
    }

    @Override
    public void removelist(List<Integer> list) {
        productDao.deletelist(list);
    }
}
