package com.it.service;

import com.github.pagehelper.Page;
import com.it.entity.Power;

import java.util.List;

public interface PowerService {
    Page<Power> selectAll(String title, Integer typeId, String remark, Boolean status);

    List<Power> selectAll2();
    Power selectById(int id);

    int insert(Power power);

    int update(Power power);

    int updateStatus(Integer id,Boolean status);

    int delete(int id);

}
