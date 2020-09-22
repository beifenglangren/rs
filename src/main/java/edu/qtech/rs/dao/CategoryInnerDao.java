package edu.qtech.rs.dao;

import edu.qtech.rs.entity.CategoryInner;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("categoryInnerDao")
public interface CategoryInnerDao {
    List<CategoryInner> selectByShopId(Integer shopId);
    void insert(CategoryInner categoryInner);
    CategoryInner selectById(Integer id);
    void update(CategoryInner categoryInner);
    List<CategoryInner> selectByName(@Param("name") String name);
    void delete(Integer id);
    CategoryInner selectEditName(@Param("id") Integer id,@Param("name") String name,@Param("sid") Integer sid);
    CategoryInner selectByNameAndSid(@Param("sid") Integer sid,@Param("name") String name);
}
