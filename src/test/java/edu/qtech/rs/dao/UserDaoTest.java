package edu.qtech.rs.dao;

import edu.qtech.rs.entity.ShopInfo;
import edu.qtech.rs.entity.UserInfo;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.List;

import static org.junit.Assert.*;
@SpringBootTest
@RunWith(SpringRunner.class)
public class UserDaoTest {
    @Autowired
    private UserDao userDao;
    @Test
    public void insertUser() {
        UserInfo user=new UserInfo();
        user.setUserUsername("123");
        user.setUserPassword("123");
        user.setUserAddress("福建");
        user.setUserAge(12);
        user.setUserIdentity(1);
        user.setUserName("张三");
        user.setUserPhone("110");
        userDao.insertUser(user);
    }
    @Test
    public void getUser(){
        UserInfo result=userDao.getUserByUsername("123");
        System.out.println(result.getUserName());
        assertNotEquals(null,result);
    }
    @Test
    public void getUserById(){
        UserInfo user=userDao.selectOne(1);
        System.out.println(user.getUserName());
        Assert.assertNotEquals(null,user.getUserName());
    }
    @Test
    public void updateUser(){
        UserInfo userInfo=new UserInfo();
        userInfo.setUserId(4);
        userInfo.setUserPhone("111");
        userInfo.setUserName("呵呵呵");
        userInfo.setUserAge(21);
        userInfo.setUserAddress("北京");
        userInfo.setUserSex("女");
        userDao.updateUser(userInfo);
    }
}