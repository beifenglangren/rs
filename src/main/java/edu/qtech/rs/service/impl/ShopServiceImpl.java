package edu.qtech.rs.service.impl;

import edu.qtech.rs.dao.ShopDao;
import edu.qtech.rs.entity.ShopInfo;
import edu.qtech.rs.service.ShopService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class ShopServiceImpl implements ShopService {
    @Autowired
    private ShopDao shopDao;
    @Override
    public List<ShopInfo> findByName(String name,String address) {
        return shopDao.selectByName(name,address);
    }

    @Override
    public ShopInfo findById(Integer id) {
        return shopDao.selectById(id);
    }

    @Override
    public List<ShopInfo> findBySale(String address) {
        return shopDao.selectBySale(address);
    }

    @Override
    public List<ShopInfo> findByCategory(Integer cid,String address) {
        return shopDao.selectByCategory(cid,address);
    }

    @Override
    public List<ShopInfo> findBySaleCount() {
        return shopDao.selectBySaleCount();
    }

    @Override
    public List<ShopInfo> findByNameAndSale(String name,String address) {
        return shopDao.selectByNameAndSale(name,address);
    }

    @Override
    public List<ShopInfo> findByNameAndReview(String name,String address) {
        return shopDao.selectByNameAndReview(name,address);
    }

    @Override
    public List<ShopInfo> findByNameAndPrice(String name,String address) {
        return shopDao.selectByNameAndPrice(name,address);
    }

    @Override
    public List<ShopInfo> findByNameAndCidAndSale(String name, Integer cid,String address) {
        return shopDao.selectByNameAndCidAndSale(name,cid,address);
    }

    @Override
    public List<ShopInfo> findByNameAndCidAndReview(String name, Integer cid,String address) {
        return shopDao.selectByNameAndCidAndReview(name,cid,address);
    }

    @Override
    public List<ShopInfo> findByNameAndCidAndPrice(String name, Integer cid,String address) {
        return shopDao.selectByNameAndCidAndPrice(name,cid,address);
    }

    @Override
    public List<ShopInfo> findOftenBuy(Integer id) {
        return shopDao.selectOftenBuy(id);
    }

    @Override
    public void modify(ShopInfo shopInfo) {
        shopDao.update(shopInfo);
    }

    @Override
    public List<ShopInfo> findByOnlyName(String shopname) {
        return shopDao.selectByOnlyName(shopname);
    }

    @Override
    public void add(ShopInfo shopInfo) {
        shopDao.insert(shopInfo);
    }

    @Override
    public List<ShopInfo> findByUid(Integer uid) {
        return shopDao.selectByUid(uid);
    }

    @Override
    public List<ShopInfo> findByStatus(Integer id) {
        return shopDao.selectByStatus(id);
    }

    @Override
    public List<ShopInfo> findByStatusAndKey(String keyword) {
        return shopDao.selectByStatusAndKey(keyword);
    }

    @Override
    public ShopInfo findByIdAndCheck(Integer id) {
        return shopDao.selectByIdAndCheck(id);
    }

    @Override
    public List<ShopInfo> findAll() {
        return shopDao.selectAll();
    }

    @Override
    public ShopInfo findByOnlyId(Integer id) {
        return shopDao.selectByOnlyId(id);
    }

    @Override
    public List<ShopInfo> findByKey(String key) {
        return shopDao.selectByKey(key);
    }

    @Override
    public List<ShopInfo> findByApply(String shopname, String add) {
        return shopDao.selectByApply(shopname, add);
    }
}
