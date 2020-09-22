package edu.qtech.rs.service.impl;

import edu.qtech.rs.dao.DealDao;
import edu.qtech.rs.entity.DealRecord;
import edu.qtech.rs.service.DealService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class DealServiceImpl implements DealService {
    @Autowired
    private DealDao dealDao;
    @Override
    public List<DealRecord> findByShopId(Integer shopId) {
        return dealDao.selectByShopId(shopId);
    }

    @Override
    public void add(DealRecord dealRecord) {
        dealDao.insert(dealRecord);
    }

}
