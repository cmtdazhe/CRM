package com.it.service.serviceImpl;

import com.it.entity.Association;
import com.it.mapper.AssociationMapper;

import com.it.service.AssociationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AssociationServiceImpl implements AssociationService {
    @Autowired
    AssociationMapper associationMapper;

    @Override
    public  List<Association> selectByCustomerId(String customerId) {
        return associationMapper.selectByCustomerId(customerId);
    }

    @Override
    public int add(Association association) {
        return associationMapper.add(association);
    }

    @Override
    public int del(Integer id) {
        return associationMapper.del(id);
    }
}

