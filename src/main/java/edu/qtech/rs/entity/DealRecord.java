package edu.qtech.rs.entity;

import java.util.Date;

public class DealRecord {
    private Integer dealId;
    private Date dealTime;
    private Integer dealResult;
    private String dealInfo;
    private Integer shopId;
    private Integer userId;
    private UserInfo user;

    public UserInfo getUser() {
        return user;
    }

    public void setUser(UserInfo user) {
        this.user = user;
    }

    public Integer getDealId() {
        return dealId;
    }

    public void setDealId(Integer dealId) {
        this.dealId = dealId;
    }

    public Date getDealTime() {
        return dealTime;
    }

    public void setDealTime(Date dealTime) {
        this.dealTime = dealTime;
    }

    public Integer getDealResult() {
        return dealResult;
    }

    public void setDealResult(Integer dealResult) {
        this.dealResult = dealResult;
    }

    public String getDealInfo() {
        return dealInfo;
    }

    public void setDealInfo(String dealInfo) {
        this.dealInfo = dealInfo;
    }

    public Integer getShopId() {
        return shopId;
    }

    public void setShopId(Integer shopId) {
        this.shopId = shopId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }
}
