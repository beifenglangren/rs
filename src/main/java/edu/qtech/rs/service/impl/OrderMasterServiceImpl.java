package edu.qtech.rs.service.impl;

import edu.qtech.rs.dao.OrderMasterDao;
import edu.qtech.rs.entity.MonthSale;
import edu.qtech.rs.entity.OrderMaster;
import edu.qtech.rs.service.OrderMasterService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OrderMasterServiceImpl implements OrderMasterService {
    @Autowired
    private OrderMasterDao orderMasterDao;
    @Override
    public void add(OrderMaster orderMaster) {
        orderMasterDao.insert(orderMaster);
    }

    @Override
    public OrderMaster findByCode(String code) {
        return orderMasterDao.selectByCode(code);
    }

    @Override
    public OrderMaster findById(Integer id) {
        return orderMasterDao.selectById(id);
    }

    @Override
    public void modify(OrderMaster orderMaster) {
        orderMasterDao.update(orderMaster);
    }

    @Override
    public List<OrderMaster> findByUserId(Integer id) {
        return orderMasterDao.selectByUserId(id);
    }

    @Override
    public List<OrderMaster> findByUserIdAndStatus(Integer uid, Integer sid) {
        return orderMasterDao.selectByUserIdAndStatus(uid,sid);
    }

    @Override
    public List<OrderMaster> findByUserIdAndKey(Integer uid, String key) {
        return orderMasterDao.selectByUserIdAndKey(uid,key);
    }

    @Override
    public List<OrderMaster> findByShopId(Integer shopId) {
        return orderMasterDao.selectByShopId(shopId);
    }

    @Override
    public List<MonthSale> findByMonth(Integer shopId) {
        return orderMasterDao.selectByMonth(shopId);
    }

    @Override
    public List<OrderMaster> findByShopAndUser(Integer uid) {
        return orderMasterDao.selectByShopAndUser(uid);
    }

    @Override
    public List<OrderMaster> findShopOrder(Integer uid) {
        return orderMasterDao.selectShopOrder(uid);
    }

    @Override
    public List<OrderMaster> findCancelShopOrder(Integer uid) {
        return orderMasterDao.selectCancelShopOrder(uid);
    }

    @Override
    public List<OrderMaster> findShopOrderByKey(String keyword,Integer uid) {
        return orderMasterDao.selectShopOrderByKey(keyword, uid);
    }

    @Override
    public List<OrderMaster> findAll() {
        return orderMasterDao.selectAll();
    }

    @Override
    public List<OrderMaster> findAllOrderByKey(String keyword) {
        return orderMasterDao.selectAllOrderByKey(keyword);
    }
}
