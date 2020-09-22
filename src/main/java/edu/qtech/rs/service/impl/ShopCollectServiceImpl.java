package edu.qtech.rs.service.impl;

import edu.qtech.rs.dao.ShopCollectDao;
import edu.qtech.rs.entity.ShopCollect;
import edu.qtech.rs.service.ShopCollectService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ShopCollectServiceImpl implements ShopCollectService {
    @Autowired
    private ShopCollectDao shopCollectDao;
    @Override
    public ShopCollect findByUidAndSid(Integer uid, Integer sid) {
        return shopCollectDao.selectByUidAndSid(uid,sid);
    }

    @Override
    public void insert(Integer uid, Integer sid) {
        shopCollectDao.insert(uid,sid);
    }

    @Override
    public void delete(Integer uid, Integer sid) {
        shopCollectDao.delete(uid, sid);
    }

    @Override
    public List<ShopCollect> findByUid(Integer uid) {
        return shopCollectDao.selectByUid(uid);
    }

    @Override
    public List<ShopCollect> findAll() {
        return shopCollectDao.selectAll();
    }

    @Override
    public List<ShopCollect> findByKey(String key) {
        return shopCollectDao.selectByKey(key);
    }

    @Override
    public void removeById(Integer id) {
        shopCollectDao.deleteById(id);
    }
}
