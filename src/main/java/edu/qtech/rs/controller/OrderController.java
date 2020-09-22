package edu.qtech.rs.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import edu.qtech.rs.entity.*;
import edu.qtech.rs.service.OrderDetailService;
import edu.qtech.rs.service.OrderMasterService;
import edu.qtech.rs.service.ProductService;
import edu.qtech.rs.service.ShopService;
import edu.qtech.rs.util.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/order")
public class OrderController {
    @Autowired
    private OrderMasterService orderMasterService;
    @Autowired
    private OrderDetailService orderDetailService;
    @Autowired
    private ShopService shopService;
    @Autowired
    private ProductService productService;
    @RequestMapping("/pay")
    public String pay(@RequestParam("masterId") Integer masterId, Model model){
        OrderMaster orderMaster=orderMasterService.findById(masterId);
        orderMaster.setOrderStatus(1);
        orderMasterService.modify(orderMaster);
        model.addAttribute("msg","恭喜您付款成功，请等待商家发货！");
        return "index1";
    }
    @RequestMapping("/topay")
    public String toPay(@RequestParam("masterId") Integer masterId,@RequestParam("desc") String desc, Model model){
        OrderMaster orderMaster=orderMasterService.findById(masterId);
        orderMaster.setOrderInfo(desc);
        orderMasterService.modify(orderMaster);
        OrderMaster orderMaster2=orderMasterService.findById(masterId);
        model.addAttribute("orderMaster",orderMaster2);
        return "pay";
    }
    @RequestMapping("/list")
    public String list(HttpSession session,Model model){
        UserInfo user=(UserInfo)session.getAttribute("user");
        List<OrderMaster> orderMasterList=orderMasterService.findByUserId(user.getUserId());
        for(OrderMaster orderMaster:orderMasterList){
            int count=0;
            List<OrderDetail> orderDetails=orderDetailService.findByMasterId(orderMaster.getOrderId());
            orderMaster.setOrderDetails(orderDetails);
            for (OrderDetail orderDetail:orderDetails){
                count+=orderDetail.getOrderCount();
            }
            orderMaster.setCount(count);
        }
        model.addAttribute("allorderMaster",orderMasterList);
        List<OrderMaster> orderMasterList1=orderMasterService.findByUserIdAndStatus(user.getUserId(),3);
        for (OrderMaster orderMaster:orderMasterList1){
            int count=0;
            List<OrderDetail> orderDetails=orderDetailService.findByMasterId(orderMaster.getOrderId());
            orderMaster.setOrderDetails(orderDetails);
            for (OrderDetail orderDetail:orderDetails){
                count+=orderDetail.getOrderCount();
            }
            orderMaster.setCount(count);
        }
        model.addAttribute("revieworderMaster",orderMasterList1);
        List<OrderMaster> orderMasterList2=orderMasterService.findByUserIdAndStatus(user.getUserId(),5);
        for (OrderMaster orderMaster:orderMasterList2){
            int count=0;
            List<OrderDetail> orderDetails=orderDetailService.findByMasterId(orderMaster.getOrderId());
            orderMaster.setOrderDetails(orderDetails);
            for (OrderDetail orderDetail:orderDetails){
                count+=orderDetail.getOrderCount();
            }
            orderMaster.setCount(count);
        }
        model.addAttribute("cancelorderMaster",orderMasterList2);
        return "ordershow";
    }
    @RequestMapping("/search")
    public String search(@RequestParam("keyword") String keyword,Model model,HttpSession session){
        UserInfo user=(UserInfo)session.getAttribute("user");
        List<OrderMaster> orderMasterList=orderMasterService.findByUserIdAndKey(user.getUserId(),keyword);
        for (OrderMaster orderMaster:orderMasterList){
            int count=0;
            List<OrderDetail> orderDetails=orderDetailService.findByMasterId(orderMaster.getOrderId());
            orderMaster.setOrderDetails(orderDetails);
            for (OrderDetail orderDetail:orderDetails){
                count+=orderDetail.getOrderCount();
            }
            orderMaster.setCount(count);
        }
        model.addAttribute("orderMasterlist",orderMasterList);
        return "searchorder";
    }
    @RequestMapping("/detail")
    public String detail(@RequestParam("masterId") Integer masterId,Model model){
        OrderMaster orderMaster=orderMasterService.findById(masterId);
        List<OrderDetail> orderDetails=orderDetailService.findByMasterId(orderMaster.getOrderId());
        orderMaster.setOrderDetails(orderDetails);
        model.addAttribute("orderMaster",orderMaster);
        return "orderdetail";
    }
    @RequestMapping("/confirm")
    public String confirm(@RequestParam("masterId") Integer masterId){
        OrderMaster orderMaster=orderMasterService.findById(masterId);
        orderMaster.setOrderStatus(3);
        orderMaster.setConfirmTime(new Date());
        orderMasterService.modify(orderMaster);
        return "redirect:../order/list";
    }
    @RequestMapping("/toreview")
    public String toReview(@RequestParam("masterId") Integer masterId,Model model){
        OrderMaster orderMaster=orderMasterService.findById(masterId);
        List<OrderDetail> orderDetails=orderDetailService.findByMasterId(orderMaster.getOrderId());
        orderMaster.setOrderDetails(orderDetails);
        model.addAttribute("orderMaster",orderMaster);
        return "review";
    }
    @RequestMapping("/cancel")
    public String cancel(@RequestParam("masterId") Integer masterId){
        OrderMaster orderMaster=orderMasterService.findById(masterId);
        orderMaster.setOrderStatus(5);
        orderMasterService.modify(orderMaster);
        return "redirect:../order/list";
    }
    @RequestMapping("/admincancel")
    public String admincancel(@RequestParam("masterId") Integer masterId){
        OrderMaster orderMaster=orderMasterService.findById(masterId);
        orderMaster.setOrderStatus(5);
        orderMasterService.modify(orderMaster);
        return "redirect:../order/ordermgt";
    }
    @RequestMapping("/cancelshoporder")
    public String cancelshoporder(@RequestParam("masterId") Integer masterId){
        OrderMaster orderMaster=orderMasterService.findById(masterId);
        orderMaster.setOrderStatus(5);
        orderMasterService.modify(orderMaster);
        return "redirect:../order/towaitorder";
    }
    @RequestMapping("/updatedesc")
    public String updatedesc(@RequestParam("orderId") Integer mid,@RequestParam("desc") String desc){
        OrderMaster orderMaster=orderMasterService.findById(mid);
        orderMaster.setOrderInfo(desc);
        orderMasterService.modify(orderMaster);
        return "redirect:../order/detail?masterId="+mid;
    }
    @RequestMapping("/towaitorder")
    public String toWaitOrder(HttpSession session,Model model){
        UserInfo user=(UserInfo)session.getAttribute("user");
        List<OrderMaster> orderMasterList=orderMasterService.findByShopAndUser(user.getUserId());
        for(OrderMaster orderMaster:orderMasterList){
            int count=0;
            List<OrderDetail> orderDetails=orderDetailService.findByMasterId(orderMaster.getOrderId());
            orderMaster.setOrderDetails(orderDetails);
            for(OrderDetail orderDetail:orderDetails){
                count+=orderDetail.getOrderCount();
            }
            orderMaster.setCount(count);
        }
        model.addAttribute("orderMasterlist",orderMasterList);
        return "waitdealorder";
    }
    @RequestMapping("/delivery")
    public String delivery(@RequestParam("orderMasterId") Integer mid){
        OrderMaster orderMaster=orderMasterService.findById(mid);
        orderMaster.setOrderStatus(2);
        orderMaster.setDeliveryTime(new Date());
        orderMasterService.modify(orderMaster);
        ShopInfo shopInfo=shopService.findById(orderMaster.getShopId());
        List<OrderDetail> orderDetails=orderDetailService.findByMasterId(orderMaster.getOrderId());
        int total=0;
        for (OrderDetail orderDetail:orderDetails){
            ProductInfo productInfo=orderDetail.getProduct();
            productInfo.setSaleCount(productInfo.getSaleCount()+orderDetail.getOrderCount());
            productInfo.setProductStock(productInfo.getProductStock()-orderDetail.getOrderCount());
            productService.update(productInfo);
            total+=orderDetail.getOrderCount();
        }
        shopInfo.setSaleCount(shopInfo.getSaleCount()+total);
        shopService.modify(shopInfo);
        return "redirect:../order/towaitorder";
    }
    @RequestMapping("/waitorderdetail")
    public String waitOrderDetail(@RequestParam("masterId") Integer masterId,Model model){
        OrderMaster orderMaster=orderMasterService.findById(masterId);
        List<OrderDetail> orderDetails=orderDetailService.findByMasterId(orderMaster.getOrderId());
        orderMaster.setOrderDetails(orderDetails);
        model.addAttribute("orderMaster",orderMaster);
        return "waitdealorderdetail";
    }
    @RequestMapping("/shopordershow")
    public String shopOrderShow(HttpSession session,Model model,Page page){
        UserInfo user=(UserInfo)session.getAttribute("user");
        PageHelper.offsetPage(page.getStart(),page.getCount());
        List<OrderMaster> orderMasterList=orderMasterService.findShopOrder(user.getUserId());
        int total=(int)new PageInfo<>(orderMasterList).getTotal();
        page.setTotal(total);
        model.addAttribute("page",page);
        for(OrderMaster orderMaster:orderMasterList){
            int count=0;
            List<OrderDetail> orderDetails=orderDetailService.findByMasterId(orderMaster.getOrderId());
            orderMaster.setOrderDetails(orderDetails);
            for(OrderDetail orderDetail:orderDetails){
                count+=orderDetail.getOrderCount();
            }
            orderMaster.setCount(count);
        }
        model.addAttribute("allorderMaster",orderMasterList);
        return "shopordershow";
    }
    @RequestMapping("/searchshoporder")
    public String searchShopOrder(@RequestParam("keyword") String keyword,Model model,HttpSession session,Page page){
        UserInfo user=(UserInfo)session.getAttribute("user");
        PageHelper.offsetPage(page.getStart(),page.getCount());
        List<OrderMaster> orderMasterList=orderMasterService.findShopOrderByKey(keyword,user.getUserId());
        int total=(int)new PageInfo<>(orderMasterList).getTotal();
        page.setTotal(total);
        page.setParam("&keyword="+keyword);
        model.addAttribute("page",page);
        for (OrderMaster orderMaster:orderMasterList){
            int count=0;
            List<OrderDetail> orderDetails=orderDetailService.findByMasterId(orderMaster.getOrderId());
            orderMaster.setOrderDetails(orderDetails);
            for (OrderDetail orderDetail:orderDetails){
                count+=orderDetail.getOrderCount();
            }
            orderMaster.setCount(count);
        }
        model.addAttribute("allorderMaster",orderMasterList);
        return "shopordershow";
    }
    @RequestMapping("/ordermgt")
    public String orderMgt(Page page,Model model){
        PageHelper.offsetPage(page.getStart(),page.getCount());
        List<OrderMaster> orderMasterList=orderMasterService.findAll();
        int total=(int)new PageInfo<>(orderMasterList).getTotal();
        page.setTotal(total);
        model.addAttribute("page",page);
        model.addAttribute("allorderMaster",orderMasterList);
        return "ordermgt";
    }
    @RequestMapping("/searchallorder")
    public String searchAllOrder(Page page,Model model,@RequestParam("keyword") String keyword){
        PageHelper.offsetPage(page.getStart(),page.getCount());
        List<OrderMaster> orderMasterList=orderMasterService.findAllOrderByKey(keyword);
        int total=(int)new PageInfo<>(orderMasterList).getTotal();
        page.setTotal(total);
        page.setParam("&keyword="+keyword);
        model.addAttribute("page",page);
        model.addAttribute("allorderMaster",orderMasterList);
        return "ordermgt";
    }
    @RequestMapping(value = "/databasebackup",method = {RequestMethod.POST,RequestMethod.GET})
    @ResponseBody
    public String databasebackup(HttpServletResponse response) throws Exception{
        String filePath="E:\\订餐系统\\订单信息\\";
        String dbName="orsfr";
        try {
            Process process = Runtime.getRuntime().exec("cmd /c E:\\mysqlbackup\\mysqldump -u root -p123456 orsfr order_master order_detail >E:\\订餐系统\\订单信息\\"+new java.util.Date().getTime()+".sql");
            return "success";
        }catch (Exception e){
            e.printStackTrace();
            return "error";
        }
    }
}
