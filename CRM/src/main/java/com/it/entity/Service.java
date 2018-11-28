package com.it.entity;

import java.io.Serializable;
import java.util.Date;

public class Service implements Serializable {
    private int id;
    private String type;
    private String title;
    private String customerId;
    private int status;
    private String request;
    private Date creationTime;
    private int creationUserId;
    private Date assignTime;
    private int assignUserId;

    private String cuName;
    private Customer customer;
    private ServiceProcess serviceProcess;

    public ServiceProcess getServiceProcess() {
        return serviceProcess;
    }

    public void setServiceProcess(ServiceProcess serviceProcess) {
        this.serviceProcess = serviceProcess;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public String getCuName() {
        return cuName;
    }

    public void setCuName(String cuName) {
        this.cuName = cuName;
    }

    public Date getCreationTime() {
        return creationTime;
    }

    public void setCreationTime(Date creationTime) {
        this.creationTime = creationTime;
    }

    public Date getAssignTime() {
        return assignTime;
    }

    public void setAssignTime(Date assignTime) {
        this.assignTime = assignTime;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getCustomerId() {
        return customerId;
    }

    public void setCustomerId(String customerId) {
        this.customerId = customerId;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getRequest() {
        return request;
    }

    public void setRequest(String request) {
        this.request = request;
    }

    public int getCreationUserId() {
        return creationUserId;
    }

    public void setCreationUserId(int creationUserId) {
        this.creationUserId = creationUserId;
    }



    public int getAssignUserId() {
        return assignUserId;
    }

    public void setAssignUserId(int assignUserId) {
        this.assignUserId = assignUserId;
    }



    @Override
    public String toString() {
        return "Service{" +
                "id=" + id +
                ", type='" + type + '\'' +
                ", title='" + title + '\'' +
                ", customerId='" + customerId + '\'' +
                ", status=" + status +
                ", request='" + request + '\'' +
                ", creationUserId=" + creationUserId +
                ", assignUserId=" + assignUserId +
                '}';
    }
}


