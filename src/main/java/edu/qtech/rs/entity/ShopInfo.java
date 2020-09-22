package edu.qtech.rs.entity;

import java.util.Date;
import java.util.List;

public class ShopInfo {
    private Integer shopId;
    private String shopName;

    public String getShopName() {
        return shopName;
    }

    public void setShopName(String shopName) {
        this.shopName = shopName;
    }

    private String shopAddress;
    private String shopDesc;
    private float shopPrice;
    private String shopPhone;
    private Integer shopStatus;
    private String shopImg;
    private Date createTime;
    private Date updateTime;
    private Integer categoryId;
    private Integer userId;
    private Integer saleCount;
    private Integer shopScore;
    private CategoryMaster categoryMaster;
    private String checkstatus;
    private List<DealRecord> dealRecords;
    private UserInfo user;

    public UserInfo getUser() {
        return user;
    }

    public void setUser(UserInfo user) {
        this.user = user;
    }

    public List<DealRecord> getDealRecords() {
        return dealRecords;
    }

    public void setDealRecords(List<DealRecord> dealRecords) {
        this.dealRecords = dealRecords;
    }

    public String getCheckstatus() {
        return checkstatus;
    }

    public void setCheckstatus(String checkstatus) {
        this.checkstatus = checkstatus;
    }

    public CategoryMaster getCategoryMaster() {
        return categoryMaster;
    }

    public void setCategoryMaster(CategoryMaster categoryMaster) {
        this.categoryMaster = categoryMaster;
    }

    @Override
    public String toString() {
        return "ShopInfo{" +
                "shopId=" + shopId +
                ", shopName='" + shopName + '\'' +
                ", shopAddress='" + shopAddress + '\'' +
                ", shopDesc='" + shopDesc + '\'' +
                ", shopPrice=" + shopPrice +
                ", shopPhone='" + shopPhone + '\'' +
                ", shopStatus=" + shopStatus +
                ", shopImg='" + shopImg + '\'' +
                ", createTime=" + createTime +
                ", updateTime=" + updateTime +
                ", categoryId=" + categoryId +
                ", userId=" + userId +
                ", saleCount=" + saleCount +
                ", shopScore=" + shopScore +
                '}';
    }

    public Integer getSaleCount() {
        return saleCount;
    }

    public void setSaleCount(Integer saleCount) {
        this.saleCount = saleCount;
    }

    public Integer getShopScore() {
        return shopScore;
    }

    public void setShopScore(Integer shopScore) {
        this.shopScore = shopScore;
    }

    public Integer getShopId() {
        return shopId;
    }

    public void setShopId(Integer shopId) {
        this.shopId = shopId;
    }

    public String getShopAddress() {
        return shopAddress;
    }

    public void setShopAddress(String shopAddress) {
        this.shopAddress = shopAddress;
    }

    public String getShopDesc() {
        return shopDesc;
    }

    public void setShopDesc(String shopDesc) {
        this.shopDesc = shopDesc;
    }

    public float getShopPrice() {
        return shopPrice;
    }

    public void setShopPrice(float shopPrice) {
        this.shopPrice = shopPrice;
    }

    public String getShopPhone() {
        return shopPhone;
    }

    public void setShopPhone(String shopPhone) {
        this.shopPhone = shopPhone;
    }

    public Integer getShopStatus() {
        return shopStatus;
    }

    public void setShopStatus(Integer shopStatus) {
        this.shopStatus = shopStatus;
    }

    public String getShopImg() {
        return shopImg;
    }

    public void setShopImg(String shopImg) {
        this.shopImg = shopImg;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    public Integer getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(Integer categoryId) {
        this.categoryId = categoryId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }
}
