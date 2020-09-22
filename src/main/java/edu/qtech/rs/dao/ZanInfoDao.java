package edu.qtech.rs.dao;

import edu.qtech.rs.entity.ZanInfo;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("zanInfoDao")
public interface ZanInfoDao {
    ZanInfo select(@Param("uid") Integer uid,@Param("pid") Integer pid,@Param("oid") Integer oid);
    void insert(@Param("uid") Integer uid,@Param("pid") Integer pid,@Param("oid") Integer oid);
    void delete(@Param("uid") Integer uid,@Param("pid") Integer pid,@Param("oid") Integer oid);
    List<ZanInfo> selectAll();
    List<ZanInfo> selectByKey(@Param("key") String key);
    void deleteByid(Integer id);
}
