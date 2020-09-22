package edu.qtech.rs.dao;

import edu.qtech.rs.entity.DealRecord;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("dealDao")
public interface DealDao {
    List<DealRecord> selectByShopId(Integer shopId);
    void insert(DealRecord dealRecord);
}
