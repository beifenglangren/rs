package edu.qtech.rs.util;

import edu.qtech.rs.entity.EchartsEntity;

import java.util.List;

public class ListObject {
    private List<EchartsEntity> items;
    private Integer code;
    private String msg;
    public List<EchartsEntity> getItems() {
        return items;
    }

    public void setItems(List<EchartsEntity> items) {
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
