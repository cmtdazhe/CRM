package com.it.entity;

import java.io.Serializable;
import java.util.Date;

public class ServiceProcess implements Serializable {
    private int id;
    private int serviceId;
    private int userId;
    private String process;
    private String result;
    private String satisfy;
    private Date creationTime;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getServiceId() {
        return serviceId;
    }

    public void setServiceId(int serviceId) {
        this.serviceId = serviceId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getProcess() {
        return process;
    }

    public void setProcess(String process) {
        this.process = process;
    }

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }

    public String getSatisfy() {
        return satisfy;
    }

    public void setSatisfy(String satisfy) {
        this.satisfy = satisfy;
    }

    public Date getCreationTime() {
        return creationTime;
    }

    public void setCreationTime(Date creationTime) {
        this.creationTime = creationTime;
    }

    @Override
    public String toString() {
        return "Serviceprocess{" +
                "id=" + id +
                ", serviceId=" + serviceId +
                ", userId=" + userId +
                ", process='" + process + '\'' +
                ", result='" + result + '\'' +
                ", satisfy='" + satisfy + '\'' +
                ", creationTime=" + creationTime +
                '}';
    }
}

