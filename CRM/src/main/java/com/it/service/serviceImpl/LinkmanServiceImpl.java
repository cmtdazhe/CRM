package com.it.service.serviceImpl;

import com.it.entity.Linkman;
import com.it.mapper.LinkmanMapper;
import com.it.service.LinkmanService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class LinkmanServiceImpl implements LinkmanService {
    @Autowired
    LinkmanMapper linkmanMapper;
    @Override
    public List<Linkman> selectByCustomerId(String customerId) {
        return linkmanMapper.selectByCustomerId(customerId);
    }

    @Override
    public int add(Linkman linkman) {
        return linkmanMapper.add(linkman);
    }

    @Override
    public Linkman selectById(Integer id) {
        return linkmanMapper.selectById(id);
    }

    @Override
    public int update(Linkman linkman) {
        return linkmanMapper.update(linkman);
    }

    @Override
    public int del(Integer id) {
        return linkmanMapper.del(id);
    }
}

