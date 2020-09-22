package edu.qtech.rs.controller;

import edu.qtech.rs.entity.DealRecord;
import edu.qtech.rs.entity.ShopInfo;
import edu.qtech.rs.entity.UserInfo;
import edu.qtech.rs.service.DealService;
import edu.qtech.rs.service.ShopService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.Date;

@Controller
@RequestMapping("/deal")
public class DealController {
    @Autowired
    private ShopService shopService;
    @Autowired
    private DealService dealService;
    @RequestMapping("/check")
    public String check(@RequestParam("dealway") Integer dealway, @RequestParam("content") String content, @RequestParam("shopId") Integer shopId, HttpSession session){
        ShopInfo shopInfo=shopService.findByIdAndCheck(shopId);
        UserInfo user=(UserInfo)session.getAttribute("user");
        if (dealway==0){
            shopInfo.setShopStatus(1);
            shopService.modify(shopInfo);
            DealRecord dealRecord=new DealRecord();
            dealRecord.setDealTime(new Date());
            dealRecord.setDealResult(0);
            dealRecord.setDealInfo(content);
            dealRecord.setShopId(shopId);
            dealRecord.setUserId(user.getUserId());
            dealService.add(dealRecord);
            return "redirect:../shop/tocheck";
        }
        if (dealway==1){
            DealRecord dealRecord=new DealRecord();
            dealRecord.setDealTime(new Date());
            dealRecord.setDealResult(1);
            dealRecord.setDealInfo(content);
            dealRecord.setShopId(shopId);
            dealRecord.setUserId(user.getUserId());
            dealService.add(dealRecord);
            return "redirect:../shop/tocheck";
        }
        shopInfo.setShopStatus(2);
        shopService.modify(shopInfo);
        DealRecord dealRecord=new DealRecord();
        dealRecord.setDealTime(new Date());
        dealRecord.setDealResult(2);
        dealRecord.setDealInfo(content);
        dealRecord.setShopId(shopId);
        dealRecord.setUserId(user.getUserId());
        dealService.add(dealRecord);
        return "redirect:../shop/tocheck";
    }
}
