package com.it.service.serviceImpl;

import com.github.pagehelper.Page;
import com.it.entity.LostCustomer;
import com.it.mapper.LostCustomerMapper;
import com.it.service.LostCustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LostCustomerServiceImpl implements LostCustomerService{
    @Autowired
    LostCustomerMapper lostCustomerMapper;
    @Override
    public Page<LostCustomer> selectAll(String customerId, Integer status, String cName) {
        return lostCustomerMapper.selectAll(customerId,status,cName);
    }

    @Override
    public int updateStatus(String id) {
        return lostCustomerMapper.updateStatus(id);
    }

    @Override
    public int updateStatus1(String id) {
        return lostCustomerMapper.updateStatus1(id);
    }

    @Override
    public int del(String id) {
        return lostCustomerMapper.del(id);
    }


}

