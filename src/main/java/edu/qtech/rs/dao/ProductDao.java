package edu.qtech.rs.dao;

import edu.qtech.rs.entity.ProductInfo;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("productDao")
public interface ProductDao {
    List<ProductInfo> selectByName(@Param("productname") String productname,@Param("shopid") Integer shopId);
    List<ProductInfo> selectByShopId(Integer id);
    List<ProductInfo> selectByCidAndShopId(@Param("cid") Integer cid,@Param("sid") Integer sid);
    void update(ProductInfo productInfo);
    ProductInfo selectById(Integer id);
    List<ProductInfo> selectOftenBuy(Integer id);
    void zan(Integer pid);
    void insert(ProductInfo productInfo);
    List<ProductInfo> selectByOnlyName(@Param("productname") String productname,@Param("shopid") Integer shopId);
    ProductInfo selectByEditName(@Param("productname") String productname,@Param("shopid") Integer shopId,@Param("productid") Integer productId);
    void delete(Integer id);
    void deletelist(@Param("list") List<Integer> list);
}
