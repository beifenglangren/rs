package edu.qtech.rs.util;

import edu.qtech.rs.entity.EchartsEntity;
import edu.qtech.rs.entity.MonthSaleEntity;

import java.util.List;

public class ListObjectSale {
    private List<MonthSaleEntity> items;
    private Integer code;
    private String msg;

    public List<MonthSaleEntity> getItems() {
        return items;
    }

    public void setItems(List<MonthSaleEntity> items) {
        this.items = items;
    }

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }
}
