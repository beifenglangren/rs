package edu.qtech.rs.service;

import edu.qtech.rs.entity.UserInfo;

import java.util.List;


public interface UserService {
    void addUser(UserInfo userInfo);
    UserInfo findUser(String username,String password);
    boolean isExist(String username);
    UserInfo findUserById(Integer id);
    void modifyUser(UserInfo userInfo);
    void changePassword(Integer id,String password);
    List<UserInfo> findAll();
    List<UserInfo> findByKey(String key);
    List<UserInfo> findByIdentity(Integer identity);
    UserInfo checkEditUsername(String username,Integer id);
    void remove(Integer id);
}
