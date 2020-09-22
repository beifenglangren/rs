package edu.qtech.rs.service.impl;

import edu.qtech.rs.dao.UserDao;
import edu.qtech.rs.entity.UserInfo;
import edu.qtech.rs.exceptions.UserException;
import edu.qtech.rs.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserDao userDao;
    @Override
    public void addUser(UserInfo userInfo) {
        userDao.insertUser(userInfo);
    }

    @Override
    public UserInfo findUser(String username, String password) {
        UserInfo result= userDao.getUser(username,password);
        if(result==null){
            return null;
        }
        return result;
    }

    @Override
    public boolean isExist(String username) {
        UserInfo user=userDao.getUserByUsername(username);
        if (user!=null){
            return true;
        }
        return false;
    }

    @Override
    public UserInfo findUserById(Integer id) {
        return userDao.selectOne(id);
    }

    @Override
    public void modifyUser(UserInfo userInfo) {
        userDao.updateUser(userInfo);
    }

    @Override
    public void changePassword(Integer id, String password) {
        UserInfo userInfo=userDao.selectOne(id);
        userInfo.setUserPassword(password);
        userDao.updateUser(userInfo);
    }

    @Override
    public List<UserInfo> findAll() {
        return userDao.selectAll();
    }

    @Override
    public List<UserInfo> findByKey(String key) {
        return userDao.selectByKey(key);
    }

    @Override
    public List<UserInfo> findByIdentity(Integer identity) {
        return userDao.selectByIdentity(identity);
    }

    @Override
    public UserInfo checkEditUsername(String username, Integer id) {
        return userDao.checkEditUsername(username, id);
    }

    @Override
    public void remove(Integer id) {
        userDao.delete(id);
    }
}
