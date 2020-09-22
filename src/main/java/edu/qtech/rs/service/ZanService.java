package edu.qtech.rs.service;

import edu.qtech.rs.entity.ZanInfo;

import java.util.List;

public interface ZanService {
    ZanInfo find(Integer uid,Integer pid,Integer oid);
    void add(Integer uid,Integer pid,Integer oid);
    void delete(Integer uid,Integer pid,Integer oid);
    List<ZanInfo> findAll();
    List<ZanInfo> findByKey(String key);
    void removeById(Integer id);
}
