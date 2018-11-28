package com.it.service.serviceImpl;

import com.github.pagehelper.Page;
import com.it.entity.SalesOpportunity;
import com.it.mapper.SalesOpportunityMapper;
import com.it.service.SalesOpportunityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SalesOpportunityServiceImpl implements SalesOpportunityService {
    @Autowired
    private SalesOpportunityMapper salesOpportunityMapper;

    @Override
    public Page<SalesOpportunity> selectAll(String customerName, String title, String linkman, int uid) {
        return salesOpportunityMapper.selectAll(customerName,title,linkman,uid);
    }

    @Override
    public Page<SalesOpportunity> selectAll2(String customerName, String title, String linkman, int uid) {
        return salesOpportunityMapper.selectAll2(customerName,title,linkman,uid);
    }

    @Override
    public SalesOpportunity selectById(String id) {
        return salesOpportunityMapper.selectById(id);
    }

    @Override
    public int insert(SalesOpportunity salesOpportunity) {
        return salesOpportunityMapper.insert(salesOpportunity);
    }

    @Override
    public int assign(String id, int uid) {
        return salesOpportunityMapper.assign(id,uid);
    }

    @Override
    public int update(SalesOpportunity salesOpportunity) {
        return salesOpportunityMapper.update(salesOpportunity);
    }

    @Override
    public int delete(String id) {
        return salesOpportunityMapper.delete(id);
    }

    @Override
    public int updateStatus(int status, String id) {
        return salesOpportunityMapper.updateStatus(status,id);
    }
}
