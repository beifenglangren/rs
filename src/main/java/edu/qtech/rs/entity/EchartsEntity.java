package edu.qtech.rs.entity;

import java.io.Serializable;

public class EchartsEntity implements Serializable {
    private String name;
    private Integer num;

    public EchartsEntity(String name, Integer num) {
        this.name = name;
        this.num = num;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getNum() {
        return num;
    }

    public void setNum(Integer num) {
        this.num = num;
    }
}