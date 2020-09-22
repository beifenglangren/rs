package edu.qtech.rs.service.impl;

import edu.qtech.rs.dao.OrderDetailDao;
import edu.qtech.rs.entity.OrderDetail;
import edu.qtech.rs.service.OrderDetailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OrderDetailServiceImpl implements OrderDetailService {
    @Autowired
    private OrderDetailDao orderDetailDao;
    @Override
    public void add(OrderDetail orderDetail) {
        orderDetailDao.insert(orderDetail);
    }

    @Override
    public List<OrderDetail> findByMasterId(Integer id) {
        return orderDetailDao.selectByMasterId(id);
    }

    @Override
    public List<OrderDetail> findByPid(Integer pid) {
        return orderDetailDao.selectByPid(pid);
    }

    @Override
    public void removelist(List<Integer> list) {
        orderDetailDao.deletelist(list);
    }
}
