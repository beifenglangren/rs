package edu.qtech.rs.service.impl;

import edu.qtech.rs.entity.UserInfo;
import edu.qtech.rs.service.UserService;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import static org.junit.Assert.*;
@SpringBootTest
@RunWith(SpringRunner.class)
public class UserServiceImplTest {
    @Autowired
    private UserService userService;
    @Test
    public void addUser() {
        UserInfo user=new UserInfo();
        user.setUserUsername("123");
        user.setUserPassword("123");
        user.setUserAddress("福建");
        user.setUserAge(12);
        user.setUserIdentity(1);
        user.setUserName("张三");
        user.setUserPhone("110");
        userService.addUser(user);
    }
}