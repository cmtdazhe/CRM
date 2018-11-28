package com.it.service;

import com.it.entity.Association;

import java.util.List;

public interface AssociationService {
    List<Association> selectByCustomerId(String customerId);

    int add(Association association);

    int del(Integer id);
}

