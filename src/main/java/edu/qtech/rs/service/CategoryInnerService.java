package edu.qtech.rs.service;

import edu.qtech.rs.entity.CategoryInner;

import java.util.List;

public interface CategoryInnerService {
    List<CategoryInner> findByShopId(Integer shopId);
    void add(CategoryInner categoryInner);
    CategoryInner findById(Integer id);
    void modify(CategoryInner categoryInner);
    List<CategoryInner> findByName(String name);
    void remove(Integer id);
    CategoryInner findEditName(Integer id,String name,Integer sid);
    CategoryInner findByNameAndSid(Integer sid,String name);
}
