package edu.qtech.rs.dao;

import edu.qtech.rs.entity.CategoryMaster;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.List;

import static org.junit.Assert.*;
@SpringBootTest
@RunWith(SpringRunner.class)
public class CategoryMasterDaoTest {
    @Autowired
    private CategoryMasterDao categoryMasterDao;
    @Test
    public void selectAll() {
        List<CategoryMaster> categoryMasters=categoryMasterDao.selectAll();
        for (CategoryMaster categoryMaster:categoryMasters){
            System.out.println(categoryMaster.toString());
        }
    }
}