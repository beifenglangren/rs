package edu.qtech.rs.dao;

import edu.qtech.rs.entity.OrderDetail;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("orderDetailDao")
public interface OrderDetailDao {
    void insert(OrderDetail orderDetail);
    List<OrderDetail> selectByMasterId(Integer id);
    List<OrderDetail> selectByPid(Integer pid);
    void deletelist(@Param("list") List<Integer> list);
}
