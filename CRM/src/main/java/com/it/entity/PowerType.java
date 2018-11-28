package com.it.entity;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class PowerType implements Serializable, Comparable<PowerType> {
    private Integer id;  //主键列
    private String name;  //权限类别名称


    private List<Power> powers = new ArrayList<>(); //扩展属性，记录当前权限类别拥有的子集权限信息

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public List<Power> getPowers() {
        return powers;
    }

    public void setPowers(List<Power> powers) {
        this.powers = powers;
    }

    @Override
    public boolean equals(Object obj) {
        if(obj instanceof  PowerType){
            return this.id == ((PowerType) obj).id;
        }
        return super.equals(obj);
    }

    @Override
    public String toString() {
        final StringBuffer sb = new StringBuffer("PowerType{");
        sb.append("id=").append(id);
        sb.append(", name='").append(name).append('\'');
        sb.append('}');
        return sb.toString();
    }

    @Override
    public int compareTo(PowerType o) {
        return this.id - o.id;
    }
}

