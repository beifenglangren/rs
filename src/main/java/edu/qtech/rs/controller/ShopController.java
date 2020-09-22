package edu.qtech.rs.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import edu.qtech.rs.entity.*;
import edu.qtech.rs.service.*;
import edu.qtech.rs.util.ListObject;
import edu.qtech.rs.util.ListObjectSale;
import edu.qtech.rs.util.Page;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("/shop")
public class ShopController {
    @Autowired
    private ShopService shopService;
    @Autowired
    private ProductService productService;
    @Autowired
    private ShopCollectService shopCollectService;
    @Autowired
    private CategoryMasterService categoryMasterService;
    @Autowired
    private CategoryInnerService categoryInnerService;
    @Autowired
    private OrderMasterService orderMasterService;
    @Autowired
    private DealService dealService;
    @RequestMapping("/search")
    public String search(@RequestParam("keyword") String keyword, Model model, Page page, HttpSession session){
        String city=(String)session.getAttribute("city");
        PageHelper.offsetPage(page.getStart(),page.getCount());
        List<ShopInfo> shopInfoList= shopService.findByName(keyword,city);
        int total=(int)new PageInfo<>(shopInfoList).getTotal();
        Integer cid=-1;
        page.setParam("&keyword="+keyword+"&categoryId="+cid);
        page.setTotal(total);
        model.addAttribute("page",page);
        model.addAttribute("shoplist",shopInfoList);
        return "shoplist";
    }
    @RequestMapping("/categorylist")
    public String categoryList(@RequestParam("categoryId") Integer cid,Model model, Page page,HttpSession session){
        String city=(String)session.getAttribute("city");
        PageHelper.offsetPage(page.getStart(),page.getCount());
        List<ShopInfo> shopInfoList=shopService.findByCategory(cid,city);
        int total=(int)new PageInfo<>(shopInfoList).getTotal();
        page.setParam("&categoryId="+cid+"&keyword="+"");
        page.setTotal(total);
        model.addAttribute("page",page);
        model.addAttribute("shoplist",shopInfoList);
        return "shoplist";
    }
    @RequestMapping("/sort")
    public String sort(@RequestParam("sort") Integer sort,@RequestParam("keyword") String keyword, Page page,Model model,@RequestParam("categoryId") Integer cid,HttpSession session){
        String city=(String)session.getAttribute("city");
        if(cid<0){
            if(sort==1){
                PageHelper.offsetPage(page.getStart(),page.getCount());
                List<ShopInfo> shopInfoList=shopService.findByNameAndSale(keyword,city);
                int total=(int)new PageInfo<>(shopInfoList).getTotal();
                page.setParam("&keyword="+keyword+"&sort="+sort+"&categoryId="+cid);
                page.setTotal(total);
                model.addAttribute("page",page);
                model.addAttribute("shoplist",shopInfoList);
                return "shoplist";
            }
            else if(sort==2){
                PageHelper.offsetPage(page.getStart(),page.getCount());
                List<ShopInfo> shopInfoList=shopService.findByNameAndReview(keyword,city);
                int total=(int)new PageInfo<>(shopInfoList).getTotal();
                page.setParam("&keyword="+keyword+"&sort="+sort+"&categoryId="+cid);
                page.setTotal(total);
                model.addAttribute("page",page);
                model.addAttribute("shoplist",shopInfoList);
                return "shoplist";
            }
            PageHelper.offsetPage(page.getStart(),page.getCount());
            List<ShopInfo> shopInfoList=shopService.findByNameAndPrice(keyword,city);
            int total=(int)new PageInfo<>(shopInfoList).getTotal();
            page.setParam("&keyword="+keyword+"&sort="+sort+"&categoryId="+cid);
            page.setTotal(total);
            model.addAttribute("page",page);
            model.addAttribute("shoplist",shopInfoList);
            return "shoplist";
        }
        if(sort==1){
            PageHelper.offsetPage(page.getStart(),page.getCount());
            List<ShopInfo> shopInfoList=shopService.findByNameAndCidAndSale(keyword,cid,city);
            int total=(int)new PageInfo<>(shopInfoList).getTotal();
            page.setParam("&keyword="+keyword+"&sort="+sort+"&categoryId="+cid);
            page.setTotal(total);
            model.addAttribute("page",page);
            model.addAttribute("shoplist",shopInfoList);
            return "shoplist";
        }
        else if(sort==2){
            PageHelper.offsetPage(page.getStart(),page.getCount());
            List<ShopInfo> shopInfoList=shopService.findByNameAndCidAndReview(keyword,cid,city);
            int total=(int)new PageInfo<>(shopInfoList).getTotal();
            page.setParam("&keyword="+keyword+"&sort="+sort+"&categoryId="+cid);
            page.setTotal(total);
            model.addAttribute("page",page);
            model.addAttribute("shoplist",shopInfoList);
            return "shoplist";
        }
        PageHelper.offsetPage(page.getStart(),page.getCount());
        List<ShopInfo> shopInfoList=shopService.findByNameAndCidAndPrice(keyword,cid,city);
        int total=(int)new PageInfo<>(shopInfoList).getTotal();
        page.setParam("&keyword="+keyword+"&sort="+sort+"&categoryId="+cid);
        page.setTotal(total);
        model.addAttribute("page",page);
        model.addAttribute("shoplist",shopInfoList);
        return "shoplist";
    }
    @RequestMapping("/oftenbuy")
    public String oftenBuy(Model model,HttpSession session,Page page){
        UserInfo user=(UserInfo)session.getAttribute("user");
        PageHelper.offsetPage(page.getStart(),page.getCount());
        List<ShopInfo> shopInfoList=shopService.findOftenBuy(user.getUserId());
        int total=(int)new PageInfo<>(shopInfoList).getTotal();
        page.setTotal(total);
        model.addAttribute("page",page);
        model.addAttribute("shoplist",shopInfoList);
        return "regularshops";
    }
    @RequestMapping("/collectconfirm")
    @ResponseBody
    public String collectConfirm(@RequestParam("sid") Integer sid,HttpSession session){
        UserInfo user=(UserInfo)session.getAttribute("user");
        ShopCollect shopCollect=shopCollectService.findByUidAndSid(user.getUserId(),sid);
        if(shopCollect!=null){
            return "success";
        }
        return "false";
    }
    @RequestMapping("/collect")
    @ResponseBody
    public String collect(@RequestParam("sid") Integer sid,HttpSession session){
        UserInfo user=(UserInfo)session.getAttribute("user");
        shopCollectService.insert(user.getUserId(),sid);
        return "success";
    }
    @RequestMapping("/collectcancel")
    @ResponseBody
    public String collectCancel(@RequestParam("sid") Integer sid,HttpSession session){
        UserInfo user=(UserInfo)session.getAttribute("user");
        shopCollectService.delete(user.getUserId(),sid);
        return "success";
    }
    @RequestMapping("/selfcollect")
    public String selfCollect(HttpSession session,Model model,Page page){
        UserInfo user=(UserInfo)session.getAttribute("user");
        PageHelper.offsetPage(page.getStart(),page.getCount());
        List<ShopCollect> shopCollects=shopCollectService.findByUid(user.getUserId());
        int total=(int)new PageInfo<>(shopCollects).getTotal();
        page.setTotal(total);
        model.addAttribute("page",page);
        model.addAttribute("shopcollect",shopCollects);
        return "collectshops";
    }
    @RequestMapping("/toapply")
    public String toApply(HttpSession session){
        List<CategoryMaster> categoryMasters=categoryMasterService.findAll();
        session.setAttribute("categorymaster",categoryMasters);
        return "applyshop";
    }
    @RequestMapping("/apply")
    public String apply(Model model,HttpServletRequest request,@RequestParam("shopImg") MultipartFile shopImg,@RequestParam("shopName") String shopName
    ,@RequestParam("shopAddress") String shopAddress,@RequestParam("shopDesc") String shopDesc,@RequestParam("shopPrice") float shopPrice,
    @RequestParam("shopPhone") String shopPhone,@RequestParam("categoryId") Integer categoryId,HttpSession session){
        UserInfo user=(UserInfo)session.getAttribute("user");
        List<ShopInfo> shopInfos=shopService.findByApply(shopName,shopAddress);
        if(shopInfos.size()!=0){
            model.addAttribute("msg","您注册的店名已经被注册了，请换一个店名吧！");
            return "applyshop";
        }
        ShopInfo shopInfo=new ShopInfo();
        String shopNewImg=uploadFileList(shopImg,request);
        shopInfo.setShopImg(shopNewImg);
        shopInfo.setShopName(shopName);
        shopInfo.setShopAddress(shopAddress);
        shopInfo.setShopDesc(shopDesc);
        shopInfo.setShopPhone(shopPhone);
        shopInfo.setCategoryId(categoryId);
        shopInfo.setShopPrice(shopPrice);
        shopInfo.setShopStatus(0);
        shopInfo.setCreateTime(new Date());
        shopInfo.setUpdateTime(new Date());
        shopInfo.setUserId(user.getUserId());
        shopService.add(shopInfo);
        model.addAttribute("msg","恭喜您申请店铺成功！请继续您的操作！");
        return "shopindex";
    }
    @RequestMapping("/selfshops")
    public String selfShops(Model model,HttpSession session,Page page){
        UserInfo user=(UserInfo)session.getAttribute("user");
        PageHelper.offsetPage(page.getStart(),page.getCount());
        List<ShopInfo> shopInfoList=shopService.findByUid(user.getUserId());
        int total=(int)new PageInfo<>(shopInfoList).getTotal();
        page.setTotal(total);
        model.addAttribute("page",page);
        model.addAttribute("shoplist",shopInfoList);
        return "selfshops";
    }
    @RequestMapping("/detail")
    public String detail(@RequestParam("shopId") Integer shopId,Model model){
        ShopInfo shopInfo=shopService.findByOnlyId(shopId);
        model.addAttribute("shop",shopInfo);
        return "shopdetail";
    }
    @RequestMapping("/toedit")
    public String toEdit(@RequestParam("shopId") Integer shopId,Model model){
        ShopInfo shopInfo=shopService.findByOnlyId(shopId);
        model.addAttribute("shop",shopInfo);
        return "editshop";
    }
    @RequestMapping("/editshop")
    public String editShop(@RequestParam("shopPrice") float shopPrice,@RequestParam("shopPhone") String shopPhone,
                           @RequestParam("shopImg") MultipartFile shopImg,@RequestParam("shopDesc") String shopDesc,
                           HttpServletRequest request,@RequestParam("shopId") Integer shopId){
        if (!StringUtils.isNotBlank(shopImg.getOriginalFilename())){
            ShopInfo shopInfo=shopService.findByOnlyId(shopId);
            shopInfo.setShopPrice(shopPrice);
            shopInfo.setShopPhone(shopPhone);
            shopInfo.setShopDesc(shopDesc);
            shopInfo.setUpdateTime(new Date());
            shopService.modify(shopInfo);
            return "redirect:../shop/detail?shopId="+shopId;
        }
        ShopInfo shopInfo=shopService.findByOnlyId(shopId);
        shopInfo.setShopPrice(shopPrice);
        shopInfo.setShopPhone(shopPhone);
        shopInfo.setShopDesc(shopDesc);
        shopInfo.setUpdateTime(new Date());
        String shopNewImg=uploadFileList(shopImg,request);
        shopInfo.setShopImg(shopNewImg);
        shopService.modify(shopInfo);
        return "redirect:../shop/detail?shopId="+shopId;
    }
    @RequestMapping("/toreport")
    public String toReport(@RequestParam("shopId") Integer shopId,Model model){
        model.addAttribute("shopId",shopId);
        return "shopreport";
    }
    @RequestMapping("/tocheck")
    public String toCheck(Page page,Model model){
        PageHelper.offsetPage(page.getStart(),page.getCount());
        List<ShopInfo> shopInfoList=shopService.findByStatus(0);
        int total=(int)new PageInfo<>(shopInfoList).getTotal();
        page.setTotal(total);
        for (ShopInfo shopInfo:shopInfoList){
            List<DealRecord> dealRecords=dealService.findByShopId(shopInfo.getShopId());
            if (dealRecords.size()==0){
                shopInfo.setCheckstatus("未审核");
            }
            if (dealRecords.size()!=0){
                shopInfo.setCheckstatus("已打回");
            }
        }
        model.addAttribute("page",page);
        model.addAttribute("shoplist",shopInfoList);
        return "checkshoplist";
    }
    @RequestMapping("/searchcheckshop")
    public String searchCheckShop(@RequestParam("keyword") String keyword,Page page,Model model){
        PageHelper.offsetPage(page.getStart(),page.getCount());
        List<ShopInfo> shopInfoList=shopService.findByStatusAndKey(keyword);
        int total=(int)new PageInfo<>(shopInfoList).getTotal();
        page.setParam("&keyword="+keyword);
        page.setTotal(total);
        for (ShopInfo shopInfo:shopInfoList){
            List<DealRecord> dealRecords=dealService.findByShopId(shopInfo.getShopId());
            if (dealRecords.size()==0){
                shopInfo.setCheckstatus("未审核");
            }
            if (dealRecords.size()!=0){
                shopInfo.setCheckstatus("已打回");
            }
        }
        model.addAttribute("page",page);
        model.addAttribute("shoplist",shopInfoList);
        return "checkshoplist";
    }
    @RequestMapping("/tocheckshop")
    public String toCheckShop(@RequestParam("shopId") Integer shopId,Model model){
        ShopInfo shopInfo=shopService.findByIdAndCheck(shopId);
        List<DealRecord> dealRecords=dealService.findByShopId(shopId);
        if (dealRecords!=null){
            shopInfo.setDealRecords(dealRecords);
        }
        model.addAttribute("shop",shopInfo);
        return "checkshop";
    }
    @RequestMapping("/adminshops")
    public String adminShops(Page page,Model model){
        PageHelper.offsetPage(page.getStart(),page.getCount());
        List<ShopInfo> shopInfoList=shopService.findAll();
        int total=(int)new PageInfo<>(shopInfoList).getTotal();
        page.setTotal(total);
        model.addAttribute("page",page);
        model.addAttribute("shoplist",shopInfoList);
        return "adminshops";
    }
    @RequestMapping("/cancelshop")
    public String cancelShop(@RequestParam("shopId") Integer shopId){
        ShopInfo shopInfo=shopService.findByOnlyId(shopId);
        shopInfo.setShopStatus(0);
        shopService.modify(shopInfo);
        return "redirect:../shop/detail?shopId="+shopId;
    }
    @RequestMapping("/shopcollectmgt")
    public String shopCollectMgt(Page page,Model model){
        PageHelper.offsetPage(page.getStart(),page.getCount());
        List<ShopCollect> shopCollectList=shopCollectService.findAll();
        int total=(int)new PageInfo<>(shopCollectList).getTotal();
        page.setTotal(total);
        model.addAttribute("page",page);
        model.addAttribute("shopCollectList",shopCollectList);
        return "shopcollectmgt";
    }
    @RequestMapping("/searchshopcollect")
    public String searchShopCollect(@RequestParam("keyword") String keyword,Page page,Model model){
        PageHelper.offsetPage(page.getStart(),page.getCount());
        List<ShopCollect> shopCollectList=shopCollectService.findByKey(keyword);
        int total=(int)new PageInfo<>(shopCollectList).getTotal();
        page.setTotal(total);
        page.setParam("&keyword="+keyword);
        model.addAttribute("page",page);
        model.addAttribute("shopCollectList",shopCollectList);
        return "shopcollectmgt";
    }
    @RequestMapping("/searchadminshops")
    public String searchAdminShops(Page page,Model model,@RequestParam("keyword") String keyword){
        PageHelper.offsetPage(page.getStart(),page.getCount());
        List<ShopInfo> shopInfoList=shopService.findByKey(keyword);
        int total=(int)new PageInfo<>(shopInfoList).getTotal();
        page.setTotal(total);
        page.setParam("&keyword="+keyword);
        model.addAttribute("page",page);
        model.addAttribute("shoplist",shopInfoList);
        return "adminshops";
    }
    @RequestMapping("/deleteshopcollect")
    public String deleteShopCollect(@RequestParam("id") Integer id){
        shopCollectService.removeById(id);
        return "redirect:../shop/shopcollectmgt";
    }
    @RequestMapping("/toshopcheckdetail")
    public String toShopCheckDetail(@RequestParam("shopId") Integer shopId,Page page,Model model){
        PageHelper.offsetPage(page.getStart(),page.getCount());
        List<DealRecord> dealRecords=dealService.findByShopId(shopId);
        int total=(int)new PageInfo<>(dealRecords).getTotal();
        page.setTotal(total);
        model.addAttribute("page",page);
        model.addAttribute("dealRecords",dealRecords);
        return "shopcheckdetail";
    }
    @RequestMapping(value = "/databasebackup",method = {RequestMethod.POST,RequestMethod.GET})
    @ResponseBody
    public String databasebackup(HttpServletResponse response) throws Exception{
        String filePath="E:\\订餐系统\\收藏信息\\";
        String dbName="orsfr";
        try {
            Process process = Runtime.getRuntime().exec("cmd /c E:\\mysqlbackup\\mysqldump -u root -p123456 orsfr shop_collect >E:\\订餐系统\\收藏信息\\"+new java.util.Date().getTime()+".sql");
            return "success";
        }catch (Exception e){
            e.printStackTrace();
            return "error";
        }
    }
    @RequestMapping("/echarts")
    @ResponseBody
    public ListObject echarts(@RequestParam("shopId") Integer shopId){
        ListObject listObject=new ListObject();
        List<EchartsEntity> list=new ArrayList<EchartsEntity>();
        List<CategoryInner> categoryInnerList=categoryInnerService.findByShopId(shopId);
        for(CategoryInner categoryInner:categoryInnerList){
            int num=0;
            List<ProductInfo> productInfoList=productService.findByCidAndShopId(categoryInner.getCategoryId(),shopId);
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
    public Map<String, Object> test2(@RequestParam("shopId") Integer shopId) throws ParseException {
        List<OrderMaster> orderMasterList=orderMasterService.findByShopId(shopId);
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
            if(orderMaster.getOrderStatus()!=0&&orderMaster.getOrderStatus()!=4){
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
    public ListObjectSale echarts3(@RequestParam("shopId") Integer shopId) throws ParseException {
        ListObjectSale listObjectSale=new ListObjectSale();
        List<MonthSaleEntity> list=new ArrayList<>();
        List<MonthSale> monthSales=orderMasterService.findByMonth(shopId);
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
    @RequestMapping("/echarts4")
    @ResponseBody
    public ListObject echarts4(@RequestParam("shopId") Integer shopId){
        ListObject listObject=new ListObject();
        List<EchartsEntity> list=new ArrayList<EchartsEntity>();
        List<ProductInfo> productInfoList=productService.findByShopId(shopId);
        for (ProductInfo productInfo:productInfoList){
            list.add(new EchartsEntity(productInfo.getProductName(),productInfo.getSaleCount()));
        }
        listObject.setItems(list);
        listObject.setCode(1);
        listObject.setMsg("成功");
        return listObject;
    }
    public static String uploadFileList(MultipartFile multipartFile, HttpServletRequest request){
        String newFileName=null;
        try {
                String originalFilename=multipartFile.getOriginalFilename();
                if(multipartFile!=null&&originalFilename!=null&&originalFilename.length()>0){
                    newFileName= UUID.randomUUID()+originalFilename;
                    String pic_path=request.getSession().getServletContext().getRealPath("/img");
                    File targetFile=new File(pic_path,newFileName);
                    multipartFile.transferTo(targetFile);
                }
        }
        catch (IOException e){
            e.printStackTrace();
        }
        return newFileName;
    }
}
