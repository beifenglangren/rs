package edu.qtech.rs.dao;

import edu.qtech.rs.entity.ShopCollect;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Repository("shopCollectDao")
public interface ShopCollectDao {
    ShopCollect selectByUidAndSid(@Param("uid") Integer uid, @Param("sid") Integer sid);
    void insert(@Param("uid") Integer uid, @Param("sid") Integer sid);
    void delete(@Param("uid") Integer uid, @Param("sid") Integer sid);
    List<ShopCollect> selectByUid(Integer uid);
    List<ShopCollect> selectAll();
    List<ShopCollect> selectByKey(@Param("key") String key);
    void deleteById(Integer id);
}
