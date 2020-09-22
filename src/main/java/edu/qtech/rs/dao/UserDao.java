package edu.qtech.rs.dao;

import edu.qtech.rs.entity.UserInfo;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("userDao")
public interface UserDao {
    void insertUser(UserInfo userInfo);
    UserInfo getUser(@Param("username") String username,@Param("password") String password);
    UserInfo getUserByUsername(@Param("username") String username);
    UserInfo selectOne(Integer id);
    void updateUser(UserInfo userInfo);
    List<UserInfo> selectAll();
    List<UserInfo> selectByKey(@Param("key") String key);
    List<UserInfo> selectByIdentity(Integer iden);
    UserInfo checkEditUsername(@Param("username") String username,@Param("id") Integer id);
    void delete(Integer id);
}
