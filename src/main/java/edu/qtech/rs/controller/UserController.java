package edu.qtech.rs.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import edu.qtech.rs.entity.CategoryMaster;
import edu.qtech.rs.entity.ShopInfo;
import edu.qtech.rs.entity.UserInfo;
import edu.qtech.rs.service.CategoryMasterService;
import edu.qtech.rs.service.ShopService;
import edu.qtech.rs.service.UserService;
import edu.qtech.rs.util.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import com.google.code.kaptcha.Constants;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/user")
public class UserController {
    @Autowired
    private UserService userService;
    @Autowired
    private ShopService shopService;
    @Autowired
    private CategoryMasterService categoryMasterService;
    @RequestMapping("/tologin")
    public String toLogin(){
        return "login";
    }
    @RequestMapping("/login")
    public String login(Model model, @RequestParam("username") String username, @RequestParam("password") String password,
                        HttpSession session){
        UserInfo result=userService.findUser(username,password);
        if(result==null){
            model.addAttribute("msg","用户名密码出现错误！请重新输入！");
            return "login";
        }
        session.setAttribute("user",result);
        return "dingwei";
    }
    @RequestMapping("/logout")
    public String logout(HttpSession session){
        session.removeAttribute("user");
        return "login";
    }
    @RequestMapping("/toregister")
    public String toRegister(){
        return "register";
    }
    @RequestMapping("/register")
    public String register(Model model, UserInfo user, HttpServletRequest request){
        String verifyCodeExpected=(String)request.getSession().getAttribute(Constants.KAPTCHA_SESSION_KEY);
        String verifyCodeActual=request.getParameter("j_captcha");
        if(verifyCodeActual==null||!verifyCodeActual.equalsIgnoreCase(verifyCodeExpected)){
            model.addAttribute("msg","验证码错误！请重新输入！");
            return "register";
        }
        boolean result=userService.isExist(user.getUserUsername());
        if(result){
            model.addAttribute("msg","用户名已经存在！请重新注册！");
            return "register";
        }
        userService.addUser(user);
        model.addAttribute("msg","恭喜您注册成功！请继续登录吧！");
        return "login";
    }
    @RequestMapping("/info")
    public String info(){
        return "queryinfo";
    }
    @RequestMapping("/toeditinfo")
    public String toEditInfo(){
        return "editinfo";
    }
    @RequestMapping("/editinfo")
    public String editInfo(Model model,UserInfo userinfo,HttpSession session){
        userService.modifyUser(userinfo);
        UserInfo user=userService.findUserById(userinfo.getUserId());
        session.setAttribute("user",user);
        if(user.getUserIdentity()==0){
            return "index1";
        }
        else if(user.getUserIdentity()==1){
            return "shopindex";
        }
        return "adminindex";
    }
    @RequestMapping("/tochangepassword")
    public String toChangePassword(){
        return "changepassword";
    }
    @RequestMapping("/changepassword")
    public String changePassword(@RequestParam("userPassword") String userPassword,HttpSession session){
        UserInfo result=(UserInfo)session.getAttribute("user");
        userService.changePassword(result.getUserId(),userPassword);
        UserInfo user=userService.findUserById(result.getUserId());
        session.setAttribute("user",user);
        if(user.getUserIdentity()==0){
            return "index1";
        }
        else if(user.getUserIdentity()==1){
            return "shopindex";
        }
        return "adminindex";
    }
    @RequestMapping("/index")
    public String index(Model model,HttpSession session){
        String city=(String)session.getAttribute("city");
        List<ShopInfo> shopInfoList=shopService.findBySale(city);
        session.setAttribute("hotshop",shopInfoList);
        List<CategoryMaster> categoryMasters=categoryMasterService.findAll();
        session.setAttribute("categorymaster",categoryMasters);
        return "index1";
    }
    @RequestMapping("/dingwei")
    public String dingwei(HttpSession session,String city){
        UserInfo user=(UserInfo)session.getAttribute("user");
        session.setAttribute("city",city);
        if(user.getUserIdentity()==0){
            return "redirect:../user/index";
        }
        else if(user.getUserIdentity()==1){
            return "redirect:../user/shopindex";
        }
        return "redirect:../user/adminindex";
    }
    @RequestMapping("/shopindex")
    public String shopindex(){
        return "shopindex";
    }
    @RequestMapping("/adminindex")
    public String adminindex(){
        return "adminindex";
    }
    @RequestMapping("/usermgt")
    public String userMgt(Model model, Page page){
        PageHelper.offsetPage(page.getStart(),page.getCount());
        List<UserInfo> userInfoList=userService.findAll();
        int total=(int)new PageInfo<>(userInfoList).getTotal();
        page.setTotal(total);
        model.addAttribute("page",page);
        model.addAttribute("userlist",userInfoList);
        return "usermgt";
    }
    @RequestMapping("/search")
    public String search(@RequestParam("keyword") String keyword,Page page,Model model){
        PageHelper.offsetPage(page.getStart(),page.getCount());
        List<UserInfo> userInfoList=userService.findByKey(keyword);
        int total=(int)new PageInfo<>(userInfoList).getTotal();
        page.setTotal(total);
        page.setParam("&keyword="+keyword);
        model.addAttribute("page",page);
        model.addAttribute("userlist",userInfoList);
        return "usermgt";
    }
    @RequestMapping("/add")
    public String add(UserInfo userInfo){
        userInfo.setUserPassword("000000");
        userService.addUser(userInfo);
        return "redirect:../user/usermgt";
    }
    @RequestMapping("/userbyiden")
    public String userByIden(@RequestParam("identity") Integer identity,Page page,Model model){
        PageHelper.offsetPage(page.getStart(),page.getCount());
        List<UserInfo> userInfoList=userService.findByIdentity(identity);
        int total=(int)new PageInfo<>(userInfoList).getTotal();
        page.setTotal(total);
        page.setParam("&identity="+identity);
        model.addAttribute("page",page);
        model.addAttribute("userlist",userInfoList);
        return "usermgt";
    }
    @RequestMapping("/detail")
    public String detail(@RequestParam("userId") Integer userId,Model model){
        UserInfo userInfo=userService.findUserById(userId);
        model.addAttribute("userinfo",userInfo);
        return "userdetail";
    }
    @RequestMapping("/toedituser")
    public String toEditUser(@RequestParam("userId") Integer userId,Model model){
        UserInfo userInfo=userService.findUserById(userId);
        model.addAttribute("userinfo",userInfo);
        return "edituser";
    }
    @RequestMapping("/edituser")
    public String editUser(UserInfo userInfo){
        userService.modifyUser(userInfo);
        return "redirect:../user/usermgt";
    }
    @RequestMapping("/deleteuser")
    public String deleteUser(@RequestParam("userId") Integer userId){
        userService.remove(userId);
        return "redirect:../user/usermgt";
    }
    @RequestMapping("/checkusername")
    @ResponseBody
    public String checkUsername(@RequestParam("username") String username){
        boolean result=userService.isExist(username);
        if (result){
            return "false";
        }
        return "success";
    }
    @RequestMapping(value = "/databasebackup",method = {RequestMethod.POST,RequestMethod.GET})
    @ResponseBody
    public String databasebackup(HttpServletResponse response) throws Exception{
        String filePath="E:\\订餐系统\\用户信息\\";
        String dbName="orsfr";
        try {
            Process process = Runtime.getRuntime().exec("cmd /c E:\\mysqlbackup\\mysqldump -u root -p123456 orsfr user_info >E:\\订餐系统\\用户信息\\"+new java.util.Date().getTime()+".sql");
            return "success";
        }catch (Exception e){
            e.printStackTrace();
            return "error";
        }
    }
    @RequestMapping("/checkeditusername")
    @ResponseBody
    public String checkEditUsername(@RequestParam("username") String username,@RequestParam("userId") Integer userId){
        UserInfo userInfo=userService.checkEditUsername(username,userId);
        if (userInfo!=null){
            return "false";
        }
        return "success";
    }
}
