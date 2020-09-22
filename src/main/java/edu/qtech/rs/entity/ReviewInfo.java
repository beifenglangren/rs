package edu.qtech.rs.entity;

import java.util.Date;
import java.util.List;

public class ReviewInfo {
    private Integer reviewId;
    private String reviewContent;
    private Integer reviewScore;
    private Date createTime;
    private Integer userId;
    private Integer shopId;
    private Integer orderId;
    private UserInfo user;
    private List<MessageInfo> messageInfos;
    private ShopInfo shop;
    private List<OrderDetail> orderDetails;

    public List<OrderDetail> getOrderDetails() {
        return orderDetails;
    }

    public void setOrderDetails(List<OrderDetail> orderDetails) {
        this.orderDetails = orderDetails;
    }

    public ShopInfo getShop() {
        return shop;
    }

    public void setShop(ShopInfo shop) {
        this.shop = shop;
    }

    public List<MessageInfo> getMessageInfos() {
        return messageInfos;
    }

    public void setMessageInfos(List<MessageInfo> messageInfos) {
        this.messageInfos = messageInfos;
    }

    public UserInfo getUser() {
        return user;
    }

    public void setUser(UserInfo user) {
        this.user = user;
    }

    public String getReviewContent() {
        return reviewContent;
    }

    public void setReviewContent(String reviewContent) {
        this.reviewContent = reviewContent;
    }

    public Integer getOrderId() {
        return orderId;
    }

    public void setOrderId(Integer orderId) {
        this.orderId = orderId;
    }

    public Integer getReviewId() {
        return reviewId;
    }

    public void setReviewId(Integer reviewId) {
        this.reviewId = reviewId;
    }



    public Integer getReviewScore() {
        return reviewScore;
    }

    public void setReviewScore(Integer reviewScore) {
        this.reviewScore = reviewScore;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getShopId() {
        return shopId;
    }

    public void setShopId(Integer shopId) {
        this.shopId = shopId;
    }

}
