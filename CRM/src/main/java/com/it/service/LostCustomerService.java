package com.it.service;

import com.github.pagehelper.Page;
import com.it.entity.LostCustomer;
import org.apache.ibatis.annotations.Param;

public interface LostCustomerService {
    Page<LostCustomer> selectAll(String customerId, Integer status, String cName);

    int updateStatus(String id);
    int updateStatus1(String id);

    int del(String id);
}

