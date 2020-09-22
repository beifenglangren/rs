package edu.qtech.rs.service;

import edu.qtech.rs.entity.OrderDetail;

import java.util.List;

public interface OrderDetailService {
    void add(OrderDetail orderDetail);
    List<OrderDetail> findByMasterId(Integer id);
    List<OrderDetail> findByPid(Integer pid);
    void removelist(List<Integer> list);
}
