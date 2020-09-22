package edu.qtech.rs.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sun.org.apache.xpath.internal.operations.Mod;
import edu.qtech.rs.entity.*;
import edu.qtech.rs.service.*;
import edu.qtech.rs.util.Page;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.math.RandomUtils;
import org.apache.ibatis.annotations.Param;
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
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/product")
public class ProductController {
    @Autowired
    private ProductService productService;
    @Autowired
    private ShopService shopService;
    @Autowired
    private CategoryInnerService categoryInnerService;
    @Autowired
    private OrderDetailService orderDetailService;
    @Autowired
    private OrderMasterService orderMasterService;
    @Autowired
    private ZanService zanService;
    @Autowired
    private ReviewService reviewService;
    @Autowired
    private MessageService messageService;
    @RequestMapping("/list")
    public String list(@RequestParam("shopId") Integer shopId,Model model){
        ShopInfo shopinfo=shopService.findById(shopId);
        List<CategoryInner> categoryInnerList=categoryInnerService.findByShopId(shopId);
        for(CategoryInner categoryInner:categoryInnerList){
            List<ProductInfo> productInfoList=productService.findByCidAndShopId(categoryInner.getCategoryId(),shopId);
            categoryInner.setProductInfos(productInfoList);
        }
        List<ReviewInfo> reviewInfos=reviewService.findBySid(shopId);
        for (ReviewInfo reviewInfo:reviewInfos){
            List<MessageInfo> messageInfos=messageService.find(reviewInfo.getReviewId());
            reviewInfo.setMessageInfos(messageInfos);
        }
        model.addAttribute("reviewinfos",reviewInfos);
        model.addAttribute("categoryinnerlist",categoryInnerList);
        model.addAttribute("shop",shopinfo);
        return "specificshop";
    }
    @RequestMapping("/settle")
    public String settle(@RequestParam("productId") Integer[] productId, @RequestParam("input-num") Integer[] num, Model model, HttpSession session){
        String city=(String)session.getAttribute("city");
        ShopInfo shopInfo=productService.findById(productId[0]).getShop();
        UserInfo userInfo=(UserInfo)session.getAttribute("user");
        OrderMaster orderMaster=new OrderMaster();
        String ordercode=new SimpleDateFormat("yyyyMMddHHmmss").format(new Date())+ RandomUtils.nextInt(10000);
        orderMaster.setOrderCode(ordercode);
        orderMaster.setOrderAddress(city);
        orderMaster.setOrderReceiver(userInfo.getUserName());
        orderMaster.setOrderPhone(userInfo.getUserPhone());
        orderMaster.setOrderStatus(0);
        orderMaster.setCreateTime(new Date());
        orderMaster.setUserId(userInfo.getUserId());
        orderMaster.setShopId(shopInfo.getShopId());
        orderMasterService.add(orderMaster);
        OrderMaster orderMaster2=orderMasterService.findByCode(ordercode);
        float total=0;
        for (int i=0;i<num.length;i++){
            if(num[i]>0){
                OrderDetail orderDetail=new OrderDetail();
                ProductInfo productInfo=productService.findById(productId[i]);
                float amount=productInfo.getProductPrice()*num[i];
                total+=amount;
                orderDetail.setOrderCount(num[i]);
                orderDetail.setOrderAmount(amount);
                orderDetail.setProductId(productId[i]);
                orderDetail.setShopId(shopInfo.getShopId());
                orderDetail.setMasterId(orderMaster2.getOrderId());
                orderDetail.setUserId(userInfo.getUserId());
                orderDetailService.add(orderDetail);
            }
        }
        orderMaster2.setOrderTotal(total+5);
        orderMasterService.modify(orderMaster2);
        OrderMaster orderMaster3=orderMasterService.findById(orderMaster2.getOrderId());
        List<OrderDetail> orderDetails=orderDetailService.findByMasterId(orderMaster2.getOrderId());
        orderMaster3.setOrderDetails(orderDetails);
        model.addAttribute("orderMaster",orderMaster3);
        return "orderlist";
    }
    @RequestMapping("/oftenbuy")
    public String oftenBuy(Model model,HttpSession session,Page page){
        UserInfo user=(UserInfo)session.getAttribute("user");
        PageHelper.offsetPage(page.getStart(),page.getCount());
        List<ProductInfo> productInfoList=productService.findOftenBuy(user.getUserId());
        int total=(int)new PageInfo<>(productInfoList).getTotal();
        page.setTotal(total);
        model.addAttribute("page",page);
        model.addAttribute("productlist",productInfoList);
        return "regularmeals";
    }
    @RequestMapping("/zan")
    @ResponseBody
    public String zan(@RequestParam("pid") Integer pid,@RequestParam("oid") Integer oid,HttpSession session){
        UserInfo user=(UserInfo)session.getAttribute("user");
        ZanInfo zan=zanService.find(user.getUserId(),pid,oid);
        if(zan==null){
            ProductInfo product=productService.findById(pid);
            product.setProductZan(product.getProductZan()+1);
            productService.update(product);
            zanService.add(user.getUserId(),pid,oid);
            return "success";
        }
        return "false";
    }
    @RequestMapping("/cancelzan")
    @ResponseBody
    public String cancelZan(@RequestParam("pid") Integer pid,@RequestParam("oid") Integer oid,HttpSession session){
        UserInfo user=(UserInfo)session.getAttribute("user");
        zanService.delete(user.getUserId(),pid,oid);
        ProductInfo product=productService.findById(pid);
        product.setProductZan(product.getProductZan()-1);
        productService.update(product);
        return "success";
    }
    @RequestMapping("/productmgt")
    public String productMgt(@RequestParam("shopId") Integer shopId,Page page,Model model){
        PageHelper.offsetPage(page.getStart(),page.getCount());
        List<ProductInfo> productInfoList=productService.findByShopId(shopId);
            int total=(int)new PageInfo<>(productInfoList).getTotal();
            page.setTotal(total);
            page.setParam("&shopId="+shopId);
            model.addAttribute("page",page);
            model.addAttribute("productlist",productInfoList);
            List<CategoryInner> categoryInnerList=categoryInnerService.findByShopId(shopId);
            model.addAttribute("categorylist",categoryInnerList);
            model.addAttribute("shopId",shopId);
            return "productmgt";
    }
    @RequestMapping("/productbycategory")
    public String productByCategory(@RequestParam("categoryId") Integer categoryId,@RequestParam("shopId") Integer shopId,Page page,Model model){
        PageHelper.offsetPage(page.getStart(),page.getCount());
        List<ProductInfo> productInfoList=productService.findByCidAndShopId(categoryId,shopId);
        int total=(int)new PageInfo<>(productInfoList).getTotal();
        page.setTotal(total);
        page.setParam("&categoryId="+categoryId+"&shopId="+shopId);
        model.addAttribute("page",page);
        model.addAttribute("productlist",productInfoList);
        List<CategoryInner> categoryInnerList=categoryInnerService.findByShopId(shopId);
        model.addAttribute("categorylist",categoryInnerList);
        model.addAttribute("shopId",shopId);
        return "productmgt";
    }
    @RequestMapping("/addproduct")
    public String addProduct(@RequestParam("productName") String productName, @RequestParam("productDesc") String productDesc,
                             @RequestParam("productPrice") float productPrice, @RequestParam("productStock") Integer productStock, @RequestParam("categoryId") Integer categoryId,
                             @RequestParam("productImg") MultipartFile productImg, @RequestParam("shopId") Integer shopId, HttpServletRequest request,Model model){
        ProductInfo productInfo=new ProductInfo();
        String productNewImg=uploadFileList(productImg,request);
        productInfo.setProductName(productName);
        productInfo.setProductImg(productNewImg);
        productInfo.setProductDesc(productDesc);
        productInfo.setProductPrice(productPrice);
        productInfo.setProductStock(productStock);
        productInfo.setCreateTime(new Date());
        productInfo.setUpdateTime(new Date());
        productInfo.setShopId(shopId);
        productInfo.setCategoryId(categoryId);
        productService.add(productInfo);
        return "redirect:../product/productmgt?shopId="+shopId;
    }
    @RequestMapping("/toeditproduct")
    public String toEditProduct(@RequestParam("productId") Integer productId,Model model,@RequestParam("shopId") Integer shopId){
        ProductInfo productInfo=productService.findById(productId);
        List<CategoryInner> categoryInnerList=categoryInnerService.findByShopId(shopId);
        model.addAttribute("categorylist",categoryInnerList);
        model.addAttribute("product",productInfo);
        return "editproduct";
    }
    @RequestMapping("/editproduct")
    public String editProduct(@RequestParam("productName") String productName, @RequestParam("productDesc") String productDesc,
                              @RequestParam("productPrice") float productPrice, @RequestParam("productStock") Integer productStock, @RequestParam("categoryId") Integer categoryId,
                              @RequestParam("productImg") MultipartFile productImg,@RequestParam("shopId") Integer shopId,
                              @RequestParam("productId") Integer productId,HttpServletRequest request,Model model){
        if (!StringUtils.isNotBlank(productImg.getOriginalFilename())){
            ProductInfo productInfo=productService.findById(productId);
            productInfo.setProductName(productName);
            productInfo.setProductDesc(productDesc);
            productInfo.setProductPrice(productPrice);
            productInfo.setProductStock(productStock);
            productInfo.setUpdateTime(new Date());
            productInfo.setCategoryId(categoryId);
            productService.update(productInfo);
            return "redirect:../product/productmgt?shopId="+shopId;
        }
        ProductInfo productInfo=productService.findById(productId);
        productInfo.setProductName(productName);
        productInfo.setProductDesc(productDesc);
        productInfo.setProductPrice(productPrice);
        productInfo.setProductStock(productStock);
        productInfo.setCategoryId(categoryId);
        productInfo.setUpdateTime(new Date());
        String productNewImg=uploadFileList(productImg,request);
        productInfo.setProductImg(productNewImg);
        productService.update(productInfo);
        return "redirect:../product/productmgt?shopId="+shopId;
    }
    @RequestMapping("/deleteproduct")
    public String deleteProduct(@RequestParam("productId") Integer productId){
        ProductInfo productInfo=productService.findById(productId);
        productService.remove(productId);
        return "redirect:../product/productmgt?shopId="+productInfo.getShopId();
    }
    @RequestMapping("/search")
    public String search(@RequestParam("keyword") String keyword,@RequestParam("shopId2") Integer shopId,Page page,Model model){
        PageHelper.offsetPage(page.getStart(),page.getCount());
        List<ProductInfo> productInfoList=productService.findByName(keyword,shopId);
        int total=(int)new PageInfo<>(productInfoList).getTotal();
        page.setTotal(total);
        page.setParam("&keyword="+keyword+"&shopId2="+shopId);
        model.addAttribute("page",page);
        model.addAttribute("productlist",productInfoList);
        List<CategoryInner> categoryInnerList=categoryInnerService.findByShopId(shopId);
        model.addAttribute("categorylist",categoryInnerList);
        return "productmgt";
    }
    @RequestMapping("/zanmgt")
    public String zanMgt(Page page,Model model){
        PageHelper.offsetPage(page.getStart(),page.getCount());
        List<ZanInfo> zanInfoList=zanService.findAll();
        int total=(int)new PageInfo<>(zanInfoList).getTotal();
        page.setTotal(total);
        model.addAttribute("page",page);
        model.addAttribute("zanInfoList",zanInfoList);
        return "zanmgt";
    }
    @RequestMapping("/searchzan")
    public String searchZan(Page page,Model model,@RequestParam("keyword") String keyword){
        PageHelper.offsetPage(page.getStart(),page.getCount());
        List<ZanInfo> zanInfoList=zanService.findByKey(keyword);
        int total=(int)new PageInfo<>(zanInfoList).getTotal();
        page.setTotal(total);
        page.setParam("&keyword="+keyword);
        model.addAttribute("page",page);
        model.addAttribute("zanInfoList",zanInfoList);
        return "zanmgt";
    }
    @RequestMapping("/deletezan")
    public String deleteZan(@RequestParam("zid") Integer zid,@RequestParam("pid") Integer pid){
        ProductInfo productInfo=productService.findById(pid);
        zanService.removeById(zid);
        productInfo.setProductZan(productInfo.getProductZan()-1);
        productService.update(productInfo);
        return "redirect:../product/zanmgt";
    }
    @RequestMapping("/checkname")
    @ResponseBody
    public String checkName(@RequestParam("name") String name,@RequestParam("shopId") Integer shopId){
        List<ProductInfo> productInfoList=productService.findByOnlyName(name,shopId);
        if(productInfoList.size()!=0){
            return "false";
        }
        return "success";
    }
    @RequestMapping("/checkeditname")
    @ResponseBody
    public String checkEditName(@RequestParam("name") String name,@RequestParam("shopId") Integer shopId,@RequestParam("productId") Integer productId){
        ProductInfo productInfo=productService.findByEditName(name,shopId,productId);
        if(productInfo!=null){
            return "false";
        }
        return "success";
    }
    @RequestMapping(value = "/databasebackup",method = {RequestMethod.POST,RequestMethod.GET})
    @ResponseBody
    public String databasebackup(HttpServletResponse response,@RequestParam("shopId") Integer shopId) throws Exception{
        String filePath="E:\\订餐系统\\餐品信息";
        ShopInfo shopInfo=shopService.findByOnlyId(shopId);
        String dbName="orsfr";
        try {
            Process process = Runtime.getRuntime().exec("cmd /c E:\\mysqlbackup\\mysqldump -u root -p123456 orsfr product_info --where=shop_id="+shopId+" >E:\\订餐系统\\餐品信息\\"+new java.util.Date().getTime()+shopInfo.getShopName()+".sql");
            return "success";
        }catch (Exception e){
            e.printStackTrace();
            return "error";
        }
    }
    @RequestMapping(value = "/databasebackupzan",method = {RequestMethod.POST,RequestMethod.GET})
    @ResponseBody
    public String databasebackup(HttpServletResponse response) throws Exception{
        String filePath="E:\\订餐系统\\点赞信息\\";
        String dbName="orsfr";
        try {
            Process process = Runtime.getRuntime().exec("cmd /c E:\\mysqlbackup\\mysqldump -u root -p123456 orsfr zan_info >E:\\订餐系统\\点赞信息\\"+new java.util.Date().getTime()+".sql");
            return "success";
        }catch (Exception e){
            e.printStackTrace();
            return "error";
        }
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
