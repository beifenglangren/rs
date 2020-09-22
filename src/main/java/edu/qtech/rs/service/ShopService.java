package edu.qtech.rs.service;

import edu.qtech.rs.entity.ShopInfo;

import java.util.List;

public interface ShopService {
    List<ShopInfo> findByName(String name,String address);
    ShopInfo findById(Integer id);
    List<ShopInfo> findBySale(String address);
    List<ShopInfo> findByCategory(Integer cid,String address);
    List<ShopInfo> findBySaleCount();
    List<ShopInfo> findByNameAndSale(String name,String address);
    List<ShopInfo> findByNameAndReview(String name,String address);
    List<ShopInfo> findByNameAndPrice(String name,String address);
    List<ShopInfo> findByNameAndCidAndSale(String name,Integer cid,String address);
    List<ShopInfo> findByNameAndCidAndReview(String name,Integer cid,String address);
    List<ShopInfo> findByNameAndCidAndPrice(String name,Integer cid,String address);
    List<ShopInfo> findOftenBuy(Integer id);
    void modify(ShopInfo shopInfo);
    List<ShopInfo> findByOnlyName(String shopname);
    void add(ShopInfo shopInfo);
    List<ShopInfo> findByUid(Integer uid);
    List<ShopInfo> findByStatus(Integer id);
    List<ShopInfo> findByStatusAndKey(String keyword);
    ShopInfo findByIdAndCheck(Integer id);
    List<ShopInfo> findAll();
    ShopInfo findByOnlyId(Integer id);
    List<ShopInfo> findByKey(String key);
    List<ShopInfo> findByApply(String shopname,String add);
}
