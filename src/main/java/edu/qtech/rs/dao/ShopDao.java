package edu.qtech.rs.dao;

import edu.qtech.rs.entity.ShopInfo;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("shopDao")
public interface ShopDao {
    List<ShopInfo> selectByName(@Param("shopname") String shopname,@Param("address") String address);
    ShopInfo selectById(Integer id);
    List<ShopInfo> selectBySale(@Param("address") String address);
    List<ShopInfo> selectByCategory(@Param("cid") Integer cid,@Param("address") String address);
    List<ShopInfo> selectBySaleCount();
    List<ShopInfo> selectByNameAndSale(@Param("shopname") String shopname,@Param("address") String address);
    List<ShopInfo> selectByNameAndReview(@Param("shopname") String shopname,@Param("address") String address);
    List<ShopInfo> selectByNameAndPrice(@Param("shopname") String shopname,@Param("address") String address);
    List<ShopInfo> selectByNameAndCidAndSale(@Param("shopname") String shopname,@Param("cid") Integer cid,@Param("address") String address);
    List<ShopInfo> selectByNameAndCidAndReview(@Param("shopname") String shopname,@Param("cid") Integer cid,@Param("address") String address);
    List<ShopInfo> selectByNameAndCidAndPrice(@Param("shopname") String shopname,@Param("cid") Integer cid,@Param("address") String address);
    List<ShopInfo> selectOftenBuy(Integer id);
    void update(ShopInfo shopInfo);
    List<ShopInfo> selectByOnlyName(@Param("shopname") String shopname);
    void insert(ShopInfo shopInfo);
    List<ShopInfo> selectByUid(Integer uid);
    List<ShopInfo> selectByStatus(Integer id);
    List<ShopInfo> selectByStatusAndKey(@Param("keyword") String keyword);
    ShopInfo selectByIdAndCheck(Integer id);
    List<ShopInfo> selectAll();
    ShopInfo selectByOnlyId(Integer id);
    List<ShopInfo> selectByKey(@Param("key") String key);
    List<ShopInfo> selectByApply(@Param("shopname") String shopname,@Param("add") String add);
}
