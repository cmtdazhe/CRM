package com.it.service;

import com.it.entity.SalesPlan;

import java.util.List;

public interface SalesPlanService {
    List<SalesPlan> selectAll(String opportunityId);

    int insertProcess(SalesPlan salesPlan);

    int delProcess(int id);

    int updateResult(SalesPlan salesPlan);
}
