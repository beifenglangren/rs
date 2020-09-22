package edu.qtech.rs.service.impl;

import edu.qtech.rs.dao.CategoryInnerDao;
import edu.qtech.rs.entity.CategoryInner;
import edu.qtech.rs.service.CategoryInnerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CategoryInnerServiceImpl implements CategoryInnerService {
    @Autowired
    private CategoryInnerDao categoryInnerDao;
    @Override
    public List<CategoryInner> findByShopId(Integer shopId) {
        return categoryInnerDao.selectByShopId(shopId);
    }

    @Override
    public void add(CategoryInner categoryInner) {
        categoryInnerDao.insert(categoryInner);
    }

    @Override
    public CategoryInner findById(Integer id) {
        return categoryInnerDao.selectById(id);
    }

    @Override
    public void modify(CategoryInner categoryInner) {
        categoryInnerDao.update(categoryInner);
    }

    @Override
    public List<CategoryInner> findByName(String name) {
        return categoryInnerDao.selectByName(name);
    }

    @Override
    public void remove(Integer id) {
        categoryInnerDao.delete(id);
    }

    @Override
    public CategoryInner findEditName(Integer id, String name,Integer sid) {
        return categoryInnerDao.selectEditName(id,name,sid);
    }

    @Override
    public CategoryInner findByNameAndSid(Integer sid, String name) {
        return categoryInnerDao.selectByNameAndSid(sid, name);
    }
}
