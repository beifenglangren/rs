package edu.qtech.rs.service;

import edu.qtech.rs.entity.MonthSale;
import edu.qtech.rs.entity.OrderMaster;

import java.util.List;

public interface OrderMasterService {
    void add(OrderMaster orderMaster);
    OrderMaster findByCode(String code);
    OrderMaster findById(Integer id);
    void modify(OrderMaster orderMaster);
    List<OrderMaster> findByUserId(Integer id);
    List<OrderMaster> findByUserIdAndStatus(Integer uid,Integer sid);
    List<OrderMaster> findByUserIdAndKey(Integer uid,String key);
    List<OrderMaster> findByShopId(Integer shopId);
    List<MonthSale> findByMonth(Integer shopId);
    List<OrderMaster> findByShopAndUser(Integer uid);
    List<OrderMaster> findShopOrder(Integer uid);
    List<OrderMaster> findCancelShopOrder(Integer uid);
    List<OrderMaster> findShopOrderByKey(String keyword,Integer uid);
    List<OrderMaster> findAll();
    List<OrderMaster> findAllOrderByKey(String keyword);
}
