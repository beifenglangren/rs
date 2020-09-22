package edu.qtech.rs.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import edu.qtech.rs.entity.*;
import edu.qtech.rs.service.*;
import edu.qtech.rs.util.Page;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/category")
public class CategoryController {
    @Autowired
    private CategoryInnerService categoryInnerService;
    @Autowired
    private ProductService productService;
    @Autowired
    private OrderDetailService orderDetailService;
    @Autowired
    private ShopService shopService;
    @Autowired
    private CategoryMasterService categoryMasterService;
    @RequestMapping("/listinnercategory")
    public String listInnerCategory(@RequestParam("shopId") Integer shopId, Model model, Page page){
        PageHelper.offsetPage(page.getStart(),page.getCount());
        List<CategoryInner> categoryInnerList=categoryInnerService.findByShopId(shopId);
            int total=(int)new PageInfo<>(categoryInnerList).getTotal();
            page.setTotal(total);
            page.setParam("&shopId="+shopId);
            model.addAttribute("shopId",shopId);
            model.addAttribute("page",page);
            model.addAttribute("categoryinner",categoryInnerList);
            return "innercategorymgt";
    }
    @RequestMapping("/addinnercategory")
    public String addInnerCategory(@RequestParam("shopId") Integer shopId,@RequestParam("categoryName") String categoryName){
        CategoryInner categoryInner=new CategoryInner();
        categoryInner.setCategoryName(categoryName);
        categoryInner.setShopId(shopId);
        categoryInnerService.add(categoryInner);
        return "redirect:../category/listinnercategory?shopId="+shopId;
    }
    @RequestMapping("/toeditinnercategory")
    public String toEditInnerCategory(@RequestParam("categoryId") Integer categoryId,Model model){
        CategoryInner categoryInner=categoryInnerService.findById(categoryId);
        model.addAttribute("category",categoryInner);
        return "editinnercategory";
    }
    @RequestMapping("/editinnercategory")
    public String editInnerCategory(@RequestParam("categoryId") Integer categoryId,@RequestParam("categoryName") String categoryName,Model model){
        CategoryInner categoryInner=categoryInnerService.findById(categoryId);
        categoryInner.setCategoryName(categoryName);
        categoryInnerService.modify(categoryInner);
        return "redirect:../category/listinnercategory?shopId="+categoryInner.getShopId();
    }
    @RequestMapping("/deleteinnercategory")
    public String deleteInnerCategory(@RequestParam("categoryId") Integer categoryId,Model model){
        CategoryInner categoryInner=categoryInnerService.findById(categoryId);
        categoryInnerService.remove(categoryId);
        return "redirect:../category/listinnercategory?shopId="+categoryInner.getShopId();
    }
    @RequestMapping("/categorymastermgt")
    public String categoryMasterMgt(Model model,Page page){
        PageHelper.offsetPage(page.getStart(),page.getCount());
        List<CategoryMaster> categoryMasterList=categoryMasterService.findAll();
        int total=(int)new PageInfo<>(categoryMasterList).getTotal();
        page.setTotal(total);
        model.addAttribute("page",page);
        model.addAttribute("categorymaster",categoryMasterList);
        return "categorymastermgt";
    }
    @RequestMapping("/categorymastersearch")
    public String categoryMasterSearch(@RequestParam("keyword") String keyword,Page page,Model model){
        PageHelper.offsetPage(page.getStart(),page.getCount());
        List<CategoryMaster> categoryMasterList=categoryMasterService.findByName(keyword);
        int total=(int)new PageInfo<>(categoryMasterList).getTotal();
        page.setTotal(total);
        page.setParam("&keyword="+keyword);
        model.addAttribute("page",page);
        model.addAttribute("categorymaster",categoryMasterList);
        return "categorymastermgt";
    }
    @RequestMapping("/addcategorymaster")
    public String addCategoryMaster(@RequestParam("categoryName") String categoryName,@RequestParam("categoryImg") MultipartFile categoryImg,HttpServletRequest request){
        CategoryMaster categoryMaster=new CategoryMaster();
        categoryMaster.setCategoryName(categoryName);
        String categoryNewImg=uploadFileList(categoryImg,request);
        categoryMaster.setCategoryImg(categoryNewImg);
        categoryMasterService.add(categoryMaster);
        return "redirect:../category/categorymastermgt";
    }
    @RequestMapping("/toeditcategorymaster")
    public String toEditCategoryMaster(@RequestParam("categoryId") Integer categoryId,Model model){
        CategoryMaster categoryMaster=categoryMasterService.findById(categoryId);
        model.addAttribute("category",categoryMaster);
        return "editcategorymaster";
    }
    @RequestMapping("/editcategorymaster")
    public String editCategoryMaster(@RequestParam("categoryId") Integer categoryId,@RequestParam("categoryName") String categoryName,@RequestParam("categoryImg") MultipartFile categoryImg,HttpServletRequest request){
        if (!StringUtils.isNotBlank(categoryImg.getOriginalFilename())){
            CategoryMaster categoryMaster=categoryMasterService.findById(categoryId);
            categoryMaster.setCategoryName(categoryName);
            categoryMasterService.modify(categoryMaster);
            return "redirect:../category/categorymastermgt";
        }
        CategoryMaster categoryMaster=categoryMasterService.findById(categoryId);
        categoryMaster.setCategoryName(categoryName);
        String categoryNewImg=uploadFileList(categoryImg,request);
        categoryMaster.setCategoryImg(categoryNewImg);
        categoryMasterService.modify(categoryMaster);
        return "redirect:../category/categorymastermgt";
    }
    @RequestMapping("/deletecategorymaster")
    public String deleteCategoryMaster(@RequestParam("categoryId") Integer categoryId){
        categoryMasterService.remove(categoryId);
        return "redirect:../category/categorymastermgt";
    }
    @RequestMapping("/checkname")
    @ResponseBody
    public String checkName(@RequestParam("name") String name,@RequestParam("shopId") Integer shopId){
        CategoryInner categoryInner=categoryInnerService.findByNameAndSid(shopId,name);
        if (categoryInner!=null){
            return "false";
        }
        return "success";
    }
    @RequestMapping("/checkeditname")
    @ResponseBody
    public String checkEditName(@RequestParam("name") String name,@RequestParam("categoryId") Integer categoryId,@RequestParam("shopId") Integer shopId){
        CategoryInner categoryInner=categoryInnerService.findEditName(categoryId,name,shopId);
        if(categoryInner!=null){
            return "false";
        }
        return "success";
    }
    @RequestMapping("/checkmastereditname")
    @ResponseBody
    public String checkMasterEditName(@RequestParam("name") String name,@RequestParam("categoryId") Integer categoryId){
        CategoryMaster categoryMaster=categoryMasterService.findEditName(name,categoryId);
        if(categoryMaster!=null){
            return "false";
        }
        return "success";
    }
    @RequestMapping("/checkmastername")
    @ResponseBody
    public String checkMasterName(@RequestParam("name") String name){
        CategoryMaster categoryMaster=categoryMasterService.findByOnlyName(name);
        if (categoryMaster!=null){
            return "false";
        }
        return "success";
    }
    @RequestMapping(value = "/databasebackup",method = {RequestMethod.POST,RequestMethod.GET})
    @ResponseBody
    public String databasebackup(HttpServletResponse response,@RequestParam("shopId") Integer shopId) throws Exception{
        String filePath="E:\\订餐系统\\店内分类\\";
        String dbName="orsfr";
        ShopInfo shopInfo=shopService.findByOnlyId(shopId);
        try {
            Process process = Runtime.getRuntime().exec("cmd /c E:\\mysqlbackup\\mysqldump -u root -p123456 orsfr category_inner --where=shop_id="+shopId+" >E:\\订餐系统\\店内分类\\"+new java.util.Date().getTime()+shopInfo.getShopName()+".sql");
            return "success";
        }catch (Exception e){
            e.printStackTrace();
            return "error";
        }
    }
    @RequestMapping(value = "/databasebackupmaster",method = {RequestMethod.POST,RequestMethod.GET})
    @ResponseBody
    public String databasebackupmaster(HttpServletResponse response) throws Exception{
        String filePath="E:\\订餐系统\\分类信息\\";
        String dbName="orsfr";
        try {
            Process process = Runtime.getRuntime().exec("cmd /c E:\\mysqlbackup\\mysqldump -u root -p123456 orsfr category_master >E:\\订餐系统\\分类信息\\"+new java.util.Date().getTime()+".sql");
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
