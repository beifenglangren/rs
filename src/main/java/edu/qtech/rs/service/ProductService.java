package edu.qtech.rs.service;

import edu.qtech.rs.entity.ProductInfo;

import java.util.List;

public interface ProductService {
    List<ProductInfo> findByName(String name,Integer shopId);
    List<ProductInfo> findByShopId(Integer id);
    List<ProductInfo> findByCidAndShopId(Integer cid,Integer sid);
    void update(ProductInfo productInfo);
    ProductInfo findById(Integer id);
    List<ProductInfo> findOftenBuy(Integer id);
    void add(ProductInfo productInfo);
    List<ProductInfo> findByOnlyName(String name,Integer shopId);
    ProductInfo findByEditName(String name,Integer shopId,Integer productId);
    void remove(Integer id);
    void removelist(List<Integer> list);
}
