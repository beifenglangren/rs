package edu.qtech.rs.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import edu.qtech.rs.entity.*;
import edu.qtech.rs.service.*;
import edu.qtech.rs.util.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/review")
public class ReviewController {
    @Autowired
    private ReviewService reviewService;
    @Autowired
    private OrderMasterService orderMasterService;
    @Autowired
    private ShopService shopService;
    @Autowired
    private MessageService messageService;
    @Autowired
    private OrderDetailService orderDetailService;
    @RequestMapping("/addreview")
    public String addReview(@RequestParam("sid") Integer sid, @RequestParam("oid") Integer oid, @RequestParam("score") Integer score, @RequestParam("content") String content, HttpSession session, Model model){
        UserInfo user=(UserInfo)session.getAttribute("user");
        ReviewInfo reviewInfo=new ReviewInfo();
        reviewInfo.setShopId(sid);
        reviewInfo.setOrderId(oid);
        reviewInfo.setReviewScore(score);
        reviewInfo.setReviewContent(content);
        reviewInfo.setCreateTime(new Date());
        reviewInfo.setUserId(user.getUserId());
        reviewService.insert(reviewInfo);
        OrderMaster orderMaster=orderMasterService.findById(oid);
        orderMaster.setOrderStatus(4);
        orderMasterService.modify(orderMaster);
        ShopInfo shop=shopService.findById(sid);
        List<ReviewInfo> reviewInfos=reviewService.findBySid(sid);
        List<Integer> scores=new ArrayList<>();
        int total=0;
        for (ReviewInfo reviewInfo1:reviewInfos){
            scores.add(reviewInfo1.getReviewScore());
            total+=reviewInfo1.getReviewScore();
        }
        float average=total/reviewInfos.size();
        shop.setShopScore(Math.round(average));
        shopService.modify(shop);
        model.addAttribute("msg","您已经评价成功，感谢您的支持！");
        return "index1";
    }
    @RequestMapping("/selfreview")
    public String selfReview(HttpSession session,Model model){
        UserInfo user=(UserInfo)session.getAttribute("user");
        List<ReviewInfo> reviewInfos=reviewService.findByUid(user.getUserId());
        model.addAttribute("reviewInfos",reviewInfos);
        return "selfreview";
    }
    @RequestMapping("/reviewdetail")
    public String reviewDetail(@RequestParam("reviewId") Integer reviewId,Model model){
        ReviewInfo reviewInfo=reviewService.findById(reviewId);
        List<MessageInfo> messageInfos=messageService.find(reviewId);
        OrderMaster orderMaster=orderMasterService.findById(reviewInfo.getOrderId());
        List<OrderDetail> orderDetails=orderDetailService.findByMasterId(orderMaster.getOrderId());
        reviewInfo.setOrderDetails(orderDetails);
        reviewInfo.setMessageInfos(messageInfos);
        model.addAttribute("review",reviewInfo);
        return "reviewdetail";
    }
    @RequestMapping("/reply")
    public String reply(HttpSession session,@RequestParam("reviewId") Integer reviewId,@RequestParam("content") String content){
        MessageInfo messageInfo=new MessageInfo();
        messageInfo.setContent(content);
        messageInfo.setCreateTime(new Date());
        messageInfo.setReviewId(reviewId);
        UserInfo user=(UserInfo)session.getAttribute("user");
        if(user.getUserIdentity()==0){
            messageInfo.setStatus(1);
        }
        if(user.getUserIdentity()==1){
            messageInfo.setStatus(0);
        }
        messageService.add(messageInfo);
        return "redirect:../review/reviewdetail?reviewId="+reviewId;
    }
    @RequestMapping("/delete")
    public String delete(@RequestParam("reviewId") Integer reviewId,@RequestParam("shopId") Integer shopId){
        ShopInfo shop=shopService.findById(shopId);
        List<ReviewInfo> reviewInfos=reviewService.findBySid(shopId);
        List<Integer> scores=new ArrayList<>();
        int total=0;
        for (ReviewInfo reviewInfo1:reviewInfos){
            scores.add(reviewInfo1.getReviewScore());
            total+=reviewInfo1.getReviewScore();
        }
        float average=total/reviewInfos.size();
        shop.setShopScore(Math.round(average));
        shopService.modify(shop);
        reviewService.remove(reviewId);
        return "redirect:../review/selfreview";
    }
    @RequestMapping("/deleteadmin")
    public String deleteAdmin(@RequestParam("reviewId") Integer reviewId,@RequestParam("shopId") Integer shopId){
        ShopInfo shop=shopService.findById(shopId);
        List<ReviewInfo> reviewInfos=reviewService.findBySid(shopId);
        List<Integer> scores=new ArrayList<>();
        int total=0;
        for (ReviewInfo reviewInfo1:reviewInfos){
            scores.add(reviewInfo1.getReviewScore());
            total+=reviewInfo1.getReviewScore();
        }
        float average=total/reviewInfos.size();
        shop.setShopScore(Math.round(average));
        shopService.modify(shop);
        reviewService.remove(reviewId);
        return "redirect:../review/reviewmgt";
    }
    @RequestMapping("/deletemessage")
    public String deleteMessage(@RequestParam("id") Integer mid,@RequestParam("reviewId") Integer rid){
        messageService.remove(mid);
        return "redirect:../review/reviewdetail?reviewId="+rid;
    }
    @RequestMapping("/toreplyreview")
    public String toReplyReview(HttpSession session,Model model){
        UserInfo user=(UserInfo)session.getAttribute("user");
        List<ReviewInfo> reviewInfos=reviewService.findReply(user.getUserId());
        model.addAttribute("reviewInfos",reviewInfos);
        return "shopreplyreview";
    }
    @RequestMapping("/toshopreview")
    public String toShopReview(HttpSession session,Model model,Page page){
        UserInfo user=(UserInfo)session.getAttribute("user");
        PageHelper.offsetPage(page.getStart(),page.getCount());
        List<ReviewInfo> reviewInfos=reviewService.findShopReview(user.getUserId());
        int total=(int)new PageInfo<>(reviewInfos).getTotal();
        page.setTotal(total);
        model.addAttribute("page",page);
        model.addAttribute("reviewInfos",reviewInfos);
        return "shopreviewshow";
    }
    @RequestMapping("/reviewmgt")
    public String reviewMgt(Page page,Model model){
        PageHelper.offsetPage(page.getStart(),page.getCount());
        List<ReviewInfo> reviewInfos=reviewService.findAll();
        int total=(int)new PageInfo<>(reviewInfos).getTotal();
        page.setTotal(total);
        model.addAttribute("page",page);
        model.addAttribute("reviewInfos",reviewInfos);
        return "reviewmgt";
    }
    @RequestMapping("/search")
    public String search(@RequestParam("keyword") String keyword,Page page,Model model){
        PageHelper.offsetPage(page.getStart(),page.getCount());
        List<ReviewInfo> reviewInfos=reviewService.findByKey(keyword);
        int total=(int)new PageInfo<>(reviewInfos).getTotal();
        page.setTotal(total);
        page.setParam("&keyword="+keyword);
        model.addAttribute("page",page);
        model.addAttribute("reviewInfos",reviewInfos);
        return "reviewmgt";
    }
}
