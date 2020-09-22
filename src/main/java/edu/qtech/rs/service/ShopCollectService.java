package edu.qtech.rs.service;

import edu.qtech.rs.entity.ShopCollect;

import java.util.List;

public interface ShopCollectService {
    ShopCollect findByUidAndSid(Integer uid,Integer sid);
    void insert(Integer uid,Integer sid);
    void delete(Integer uid,Integer sid);
    List<ShopCollect> findByUid(Integer uid);
    List<ShopCollect> findAll();
    List<ShopCollect> findByKey(String key);
    void removeById(Integer id);
}
