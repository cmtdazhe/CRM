package com.it.service;

import com.it.entity.Linkman;

import java.util.List;

public interface LinkmanService {
    List<Linkman> selectByCustomerId(String customerId);

    int add(Linkman linkman);

    Linkman selectById(Integer id);

    int update(Linkman linkman);

    int del(Integer id);
}
