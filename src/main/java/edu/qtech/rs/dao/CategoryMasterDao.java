package edu.qtech.rs.dao;

import edu.qtech.rs.entity.CategoryMaster;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("categoryMasterDao")
public interface CategoryMasterDao {
    List<CategoryMaster> selectAll();
    CategoryMaster selectById(Integer id);
    List<CategoryMaster> selectByName(@Param("name") String name);
    void insert(CategoryMaster categoryMaster);
    CategoryMaster selectByOnlyName(@Param("name") String name);
    void update(CategoryMaster categoryMaster);
    CategoryMaster selectEditName(@Param("name") String name,@Param("id") Integer id);
    void delete(Integer id);
}
