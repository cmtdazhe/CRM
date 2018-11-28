package com.it.service;

import com.github.pagehelper.Page;
import com.it.entity.Customer;

public interface CustomerService {
    Page<Customer> selectAll(
            String id, String name, String region, Integer userId, String level);

    Customer selectById(String id);

    int updateCustomer(Customer customer);

    int updateStatus(String id,Integer status);
}

