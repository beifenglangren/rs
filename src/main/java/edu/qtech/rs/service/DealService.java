package edu.qtech.rs.service;

import edu.qtech.rs.entity.DealRecord;

import java.util.List;

public interface DealService {
    List<DealRecord> findByShopId(Integer shopId);
    void add(DealRecord dealRecord);
}
