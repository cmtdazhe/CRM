package com.it.service.serviceImpl;

import com.github.pagehelper.Page;
import com.it.entity.Customer;
import com.it.mapper.CustomerMapper;
import com.it.service.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CustomerServiceImpl implements CustomerService {
    @Autowired
    private CustomerMapper customerMapper;
    @Override
    public Page<Customer> selectAll(String id, String name, String region, Integer userId, String level) {
        return customerMapper.selectAll(id,name,region,userId,level);
    }

    @Override
    public Customer selectById(String id) {
        return customerMapper.selectById(id);
    }

    public int updateCustomer(Customer customer){
        return customerMapper.updateCustomer(customer);
    }

    @Override
    public int updateStatus(String id, Integer status) {
        return customerMapper.updateStatus(id,status);
    }
}

