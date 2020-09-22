package edu.qtech.rs.entity;

import java.util.Date;

public class ProductInfo {
    private Integer productId;
    private String productName;
    private String productDesc;
    private float productPrice;
    private Integer productStock;
    private String productImg;
    private Date createTime;
    private Date updateTime;
    private Integer shopId;
    private Integer categoryId;
    private ShopInfo shop;
    private Integer saleCount;
    private Integer productZan;
    private CategoryInner category;

    public CategoryInner getCategory() {
        return category;
    }

    public void setCategory(CategoryInner category) {
        this.category = category;
    }

    public Integer getProductZan() {
        return productZan;
    }

    public void setProductZan(Integer productZan) {
        this.productZan = productZan;
    }

    public Integer getSaleCount() {
        return saleCount;
    }

    public void setSaleCount(Integer saleCount) {
        this.saleCount = saleCount;
    }


    public ShopInfo getShop() {
        return shop;
    }

    public void setShop(ShopInfo shop) {
        this.shop = shop;
    }

    public Integer getProductId() {
        return productId;
    }

    public void setProductId(Integer productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getProductDesc() {
        return productDesc;
    }

    public void setProductDesc(String productDesc) {
        this.productDesc = productDesc;
    }

    public float getProductPrice() {
        return productPrice;
    }

    public void setProductPrice(float productPrice) {
        this.productPrice = productPrice;
    }

    public Integer getProductStock() {
        return productStock;
    }

    public void setProductStock(Integer productStock) {
        this.productStock = productStock;
    }

    public String getProductImg() {
        return productImg;
    }

    public void setProductImg(String productImg) {
        this.productImg = productImg;
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

    public Integer getShopId() {
        return shopId;
    }

    public void setShopId(Integer shopId) {
        this.shopId = shopId;
    }

    public Integer getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(Integer categoryId) {
        this.categoryId = categoryId;
    }


}
