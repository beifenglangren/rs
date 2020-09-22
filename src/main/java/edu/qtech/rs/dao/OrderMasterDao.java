package edu.qtech.rs.dao;

import edu.qtech.rs.entity.MonthSale;
import edu.qtech.rs.entity.OrderMaster;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Repository("orderMasterDao")
public interface OrderMasterDao {
    void insert(OrderMaster orderMaster);
    OrderMaster selectByCode(@Param("code") String code);
    OrderMaster selectById(Integer id);
    void update(OrderMaster orderMaster);
    List<OrderMaster> selectByUserId(Integer id);
    List<OrderMaster> selectByUserIdAndStatus(@Param("uid") Integer uid,@Param("sid") Integer sid);
    List<OrderMaster> selectByUserIdAndKey(@Param("uid") Integer uid,@Param("key") String key);
    List<OrderMaster> selectByShopId(Integer shopId);
    List<MonthSale> selectByMonth(@Param("shopId") Integer shopId);
    List<OrderMaster> selectByShopAndUser(@Param("uid") Integer uid);
    List<OrderMaster> selectShopOrder(@Param("uid") Integer uid);
    List<OrderMaster> selectCancelShopOrder(@Param("uid") Integer uid);
    List<OrderMaster> selectShopOrderByKey(@Param("keyword") String keyword,@Param("uid") Integer uid);
    List<OrderMaster> selectAll();
    List<OrderMaster> selectAllOrderByKey(@Param("keyword") String keyword);
}
