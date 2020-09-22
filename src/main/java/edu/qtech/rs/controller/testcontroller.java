package edu.qtech.rs.controller;

import edu.qtech.rs.entity.*;
import edu.qtech.rs.service.CategoryInnerService;
import edu.qtech.rs.service.OrderMasterService;
import edu.qtech.rs.service.ProductService;
import edu.qtech.rs.util.ListObject;
import edu.qtech.rs.util.ListObjectSale;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("/girl")
public class testcontroller {
    @Autowired
    private OrderMasterService orderMasterService;
    @Autowired
    private CategoryInnerService categoryInnerService;
    @Autowired
    private ProductService productService;
    @RequestMapping("/hello")
    public String hello(){
        return "hello";
    }
    @RequestMapping("/echarts")
    @ResponseBody
    public ListObject test(){
        ListObject listObject=new ListObject();
        List<EchartsEntity> list=new ArrayList<EchartsEntity>();
        List<CategoryInner> categoryInnerList=categoryInnerService.findByShopId(1);
        for(CategoryInner categoryInner:categoryInnerList){
            int num=0;
            List<ProductInfo> productInfoList=productService.findByCidAndShopId(categoryInner.getCategoryId(),1);
            for(ProductInfo productInfo:productInfoList){
                num+=productInfo.getSaleCount();
            }
            list.add(new EchartsEntity(categoryInner.getCategoryName(),num));
        }
        listObject.setItems(list);
        listObject.setCode(1);
        listObject.setMsg("成功");
        return listObject;
    }
    @RequestMapping("/echarts2")
    @ResponseBody
    public Map<String, Object> test2() throws ParseException {
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
        String[] name= {"上午购买次数","中午购买次数","下午购买次数","晚上购买次数"};
        Integer[] data= {num1,num2,num3,num4};
        Map<String, Object> map = new HashMap<>();
        map.put("name", name);
        map.put("data", data);
        return map;
    }
    @RequestMapping("/echarts3")
    @ResponseBody
    public ListObjectSale echarts3() throws ParseException {
        ListObjectSale listObjectSale=new ListObjectSale();
        List<MonthSaleEntity> list=new ArrayList<>();
        List<MonthSale> monthSales=orderMasterService.findByMonth(1);
        for (MonthSale monthSale:monthSales){
            SimpleDateFormat sdf = new SimpleDateFormat("MM");
            Date date=sdf.parse(String.valueOf(monthSale.getMonth()));
            sdf = new SimpleDateFormat("MMM", Locale.US);
            list.add(new MonthSaleEntity(sdf.format(date),monthSale.getSale()));
        }
        listObjectSale.setItems(list);
        listObjectSale.setCode(1);
        listObjectSale.setMsg("成功");
        return listObjectSale;
    }
    @RequestMapping(value = "/databasebackup",method = {RequestMethod.POST,RequestMethod.GET})
    @ResponseBody
    public String databasebackup(HttpServletResponse response) throws Exception{
        String filePath="E:\\订餐系统\\";
        String dbName="orsfr";
        try {
            Process process = Runtime.getRuntime().exec("cmd /c E:\\mysqlbackup\\mysqldump -u root -p123456 orsfr category_inner --where='shop_id=1' >E:\\订餐系统\\"+new java.util.Date().getTime()+".sql");
            return "success";
        }catch (Exception e){
            e.printStackTrace();
            return "error";
        }
    }
}
