package com.it.entity;

import java.io.Serializable;
import java.util.Date;

public class LostCustomer implements Serializable {

    private int id;
    private String customerId;
    private  int userId;
    private Date lostDate;
    private String lostCause;
    private Integer status;
    private String uName;     // 客户经理
    private String cName;     // 客户名称

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCustomerId() {
        return customerId;
    }

    public void setCustomerId(String customerId) {
        this.customerId = customerId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public Date getLostDate() {
        return lostDate;
    }

    public void setLostDate(Date lostDate) {
        this.lostDate = lostDate;
    }

    public String getLostCause() {
        return lostCause;
    }

    public void setLostCause(String lostCause) {
        this.lostCause = lostCause;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getuName() {
        return uName;
    }

    public void setuName(String uName) {
        this.uName = uName;
    }

    public String getcName() {
        return cName;
    }

    public void setcName(String cName) {
        this.cName = cName;
    }
}

