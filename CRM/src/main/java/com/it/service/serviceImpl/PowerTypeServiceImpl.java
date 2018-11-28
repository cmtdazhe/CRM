package com.it.service.serviceImpl;

import com.it.entity.PowerType;
import com.it.mapper.PowerTypeMapper;
import com.it.service.PowerTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PowerTypeServiceImpl implements PowerTypeService {
    @Autowired
    private PowerTypeMapper powerTypeMapper;

    @Override
    public List<PowerType> selectAll() {
        return powerTypeMapper.selectAll();
    }

    @Override
    public PowerType selectById(int id) {
        return powerTypeMapper.selectById(id);
    }

    @Override
    public int insert(PowerType powerType) {
        return powerTypeMapper.insert(powerType);
    }

    @Override
    public int update(PowerType powerType) {
        return powerTypeMapper.update(powerType);
    }

    @Override
    public int delete(int id) {
        return powerTypeMapper.delete(id);
    }
}
