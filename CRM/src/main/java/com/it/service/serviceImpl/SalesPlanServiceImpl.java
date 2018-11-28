package com.it.service.serviceImpl;

import com.it.entity.SalesPlan;
import com.it.mapper.SalesPlanMapper;
import com.it.service.SalesPlanService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SalesPlanServiceImpl implements SalesPlanService {
    @Autowired
    SalesPlanMapper salesPlanMapper;

    @Override
    public List<SalesPlan> selectAll(String opportunityId) {
        return salesPlanMapper.selectAll(opportunityId);
    }

    @Override
    public int insertProcess(SalesPlan salesPlan) {
        return salesPlanMapper.insertProcess(salesPlan);
    }

    @Override
    public int delProcess(int id) {
        return salesPlanMapper.delProcess(id);
    }

    @Override
    public int updateResult(SalesPlan salesPlan) {
        return salesPlanMapper.updateResult(salesPlan);
    }
}

