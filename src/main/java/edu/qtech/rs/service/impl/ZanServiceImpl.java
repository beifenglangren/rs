package edu.qtech.rs.service.impl;

import edu.qtech.rs.dao.ZanInfoDao;
import edu.qtech.rs.entity.ZanInfo;
import edu.qtech.rs.service.ZanService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ZanServiceImpl implements ZanService {
    @Autowired
    private ZanInfoDao zanInfoDao;
    @Override
    public ZanInfo find(Integer uid, Integer pid, Integer oid) {
        return zanInfoDao.select(uid, pid, oid);
    }

    @Override
    public void add(Integer uid, Integer pid, Integer oid) {
        zanInfoDao.insert(uid, pid, oid);
    }

    @Override
    public void delete(Integer uid, Integer pid, Integer oid) {
        zanInfoDao.delete(uid, pid, oid);
    }

    @Override
    public List<ZanInfo> findAll() {
        return zanInfoDao.selectAll();
    }

    @Override
    public List<ZanInfo> findByKey(String key) {
        return zanInfoDao.selectByKey(key);
    }

    @Override
    public void removeById(Integer id) {
        zanInfoDao.deleteByid(id);
    }
}
