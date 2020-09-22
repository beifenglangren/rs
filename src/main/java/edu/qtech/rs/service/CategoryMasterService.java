package edu.qtech.rs.service;

import edu.qtech.rs.entity.CategoryMaster;

import java.util.List;

public interface CategoryMasterService {
    List<CategoryMaster> findAll();
    List<CategoryMaster> findByName(String name);
    void add(CategoryMaster categoryMaster);
    CategoryMaster findByOnlyName(String name);
    CategoryMaster findById(Integer id);
    void modify(CategoryMaster categoryMaster);
    CategoryMaster findEditName(String name,Integer id);
    void remove(Integer id);
}
