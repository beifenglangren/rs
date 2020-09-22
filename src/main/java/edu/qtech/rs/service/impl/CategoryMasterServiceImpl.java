package edu.qtech.rs.service.impl;

import edu.qtech.rs.dao.CategoryMasterDao;
import edu.qtech.rs.entity.CategoryMaster;
import edu.qtech.rs.service.CategoryMasterService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class CategoryMasterServiceImpl implements CategoryMasterService {
    @Autowired
    private CategoryMasterDao categoryMasterDao;
    @Override
    public List<CategoryMaster> findAll() {
        return categoryMasterDao.selectAll();
    }

    @Override
    public List<CategoryMaster> findByName(String name) {
        return categoryMasterDao.selectByName(name);
    }

    @Override
    public void add(CategoryMaster categoryMaster) {
        categoryMasterDao.insert(categoryMaster);
    }

    @Override
    public CategoryMaster findByOnlyName(String name) {
        return categoryMasterDao.selectByOnlyName(name);
    }

    @Override
    public CategoryMaster findById(Integer id) {
        return categoryMasterDao.selectById(id);
    }

    @Override
    public void modify(CategoryMaster categoryMaster) {
        categoryMasterDao.update(categoryMaster);
    }

    @Override
    public CategoryMaster findEditName(String name, Integer id) {
        return categoryMasterDao.selectEditName(name, id);
    }

    @Override
    public void remove(Integer id) {
        categoryMasterDao.delete(id);
    }
}
