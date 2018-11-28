package com.it.service;

import com.github.pagehelper.Page;
import com.it.entity.SalesOpportunity;

public interface SalesOpportunityService {
    Page<SalesOpportunity> selectAll(String customerName, String title, String linkman, int uid);

    Page<SalesOpportunity> selectAll2(String customerName,String title,String linkman,int uid);

    SalesOpportunity selectById(String id);

    int insert(SalesOpportunity salesOpportunity);

    int assign(String id, int uid);

    int update(SalesOpportunity salesOpportunity);

    int delete(String id);

    int updateStatus(int status,String id);
}

