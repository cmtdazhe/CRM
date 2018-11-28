package com.it.service;

import com.it.entity.PowerType;

import java.util.List;

public interface PowerTypeService {
    List<PowerType> selectAll();

    PowerType selectById(int id);

    int insert(PowerType powerType);

    int update(PowerType powerType);

    int delete(int id);
}
