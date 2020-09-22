package edu.qtech.rs.entity;

public class MonthSaleEntity {
    private String name;
    private float num;

    public MonthSaleEntity(String name, float num) {
        this.name = name;
        this.num = num;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public float getNum() {
        return num;
    }

    public void setNum(float num) {
        this.num = num;
    }
}
