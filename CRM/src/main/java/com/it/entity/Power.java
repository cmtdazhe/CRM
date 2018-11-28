package com.it.entity;

import java.io.Serializable;

public class Power implements Serializable {
    private Integer id;     //权限编号
    private String title;   //标题
    private Integer typeId; //父级类别
    private String url;    //链接地址
    private String remark; //描述
    private boolean status; //状态  true正常   false禁止

    private boolean checked; //扩展属性，用于前端页面显示时决定是否需要默认勾选

    //添加的一个扩展属性(代表当前权限的父级类别对象)
    private PowerType powerType;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Integer getTypeId() {
        return typeId;
    }

    public void setTypeId(Integer typeId) {
        this.typeId = typeId;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public PowerType getPowerType() {
        return powerType;
    }

    public void setPowerType(PowerType powerType) {
        this.powerType = powerType;
    }

    public boolean isChecked() {
        return checked;
    }

    public void setChecked(boolean checked) {
        this.checked = checked;
    }

    @Override
    public String toString() {
        return "Power{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", typeId=" + typeId +
                ", url='" + url + '\'' +
                ", remark='" + remark + '\'' +
                ", status=" + status +
                '}';
    }

    @Override
    public boolean equals(Object obj) {
        if (obj instanceof Power) {
            return this.id == ((Power) obj).id;
        }
        return super.equals(obj);
    }
}

