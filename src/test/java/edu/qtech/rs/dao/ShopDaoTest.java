package edu.qtech.rs.dao;

import edu.qtech.rs.entity.MonthSale;
import edu.qtech.rs.entity.OrderMaster;
import edu.qtech.rs.entity.ShopInfo;
import edu.qtech.rs.service.OrderMasterService;
import org.apache.commons.lang.time.DateUtils;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import javax.xml.crypto.Data;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import static org.junit.Assert.*;
@SpringBootTest
@RunWith(SpringRunner.class)
public class ShopDaoTest {
    @Autowired
    private ShopDao shopDao;
    @Autowired
    private OrderMasterService orderMasterService;
    @Autowired
    private OrderMasterDao orderMasterDao;
    @Test
    public void selectByName() {
        List<ShopInfo> shopInfoList=shopDao.selectByName("小笼包","1");
        System.out.println(shopInfoList.get(0).getShopName());
    }
    @Test
    public void selectById(){
        ShopInfo shopInfo=shopDao.selectById(1);
        System.out.println(shopInfo.getShopName());
    }
    @Test
    public void selectBySale(){
        List<ShopInfo> shopInfoList=shopDao.selectBySale("1");
        for(ShopInfo shopInfo:shopInfoList){
            System.out.println(shopInfo.toString());
        }
    }
    @Test
    public void selectByCategory(){
        List<ShopInfo> shopInfoList=shopDao.selectByCategory(1,"");
        for(ShopInfo shopInfo:shopInfoList){
            System.out.println(shopInfo.toString());
        }
    }
    @Test
    public void selectBySaleCount(){
        List<ShopInfo> shopInfoList=shopDao.selectByNameAndSale("小笼包","");
        for(ShopInfo shopInfo:shopInfoList){
            System.out.println(shopInfo.toString());
        }
    }
    @Test
    public void selectByMonth() throws ParseException {
        List<MonthSale> monthSales=orderMasterDao.selectByMonth(1);
        for (MonthSale monthSale:monthSales){
            SimpleDateFormat sdf = new SimpleDateFormat("MM");
            Date date=sdf.parse(String.valueOf(monthSale.getMonth()));
            sdf = new SimpleDateFormat("MMM", Locale.US);
            System.out.println("月份："+sdf.format(date)+"销售额："+monthSale.getSale());
        }
    }
    @Test
    public void selectDate() throws ParseException {
        List<OrderMaster> orderMasterList=orderMasterService.findByShopId(1);
        SimpleDateFormat sf = new SimpleDateFormat("HH:mm:ss");
        Date d1=sf.parse("06:00:00");
        String d1s=sf.format(d1);
        Date d2=sf.parse("11:00:00");
        String d2s=sf.format(d2);
        Date d4=sf.parse("14:00:00");
        String d4s=sf.format(d4);
        Date d6=sf.parse("18:00:00");
        String d6s=sf.format(d6);
        Date d8=sf.parse("22:00:00");
        String d8s=sf.format(d8);
        int strDateBeginH1 = Integer.parseInt(d1s.substring(0, 2));
        int strDateBeginH2 = Integer.parseInt(d2s.substring(0, 2));
        int strDateBeginH4 = Integer.parseInt(d4s.substring(0, 2));
        int strDateBeginH6 = Integer.parseInt(d6s.substring(0, 2));
        int strDateBeginH8 = Integer.parseInt(d8s.substring(0, 2));
        int num1=0;int num2=0;int num3=0;int num4=0;
        for(OrderMaster orderMaster:orderMasterList){
            Date date=orderMaster.getCreateTime();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String strDate = sdf.format(date);
            int strDateH=Integer.parseInt(strDate.substring(11,13));
            if (strDateH>strDateBeginH1&&strDateH<strDateBeginH2){
                num1+=1;
            }
            else if(strDateH>=strDateBeginH2&&strDateH<strDateBeginH4){
                num2+=1;
            }
            else if(strDateH>=strDateBeginH4&&strDateH<strDateBeginH6){
                num3+=1;
            }
            else if(strDateH>=strDateBeginH6&&strDateH<strDateBeginH8){
                num4+=1;
            }
        }
        System.out.println("早晨购买次数："+num1+"中午购买次数："+num2+"下午购买次数："+num3+"晚上购买次数："+num4);
    }
}