package com.it.service.serviceImpl;

import com.github.pagehelper.Page;
import com.it.entity.Power;
import com.it.mapper.PowerMapper;
import com.it.service.PowerService;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PowerServiceImpl implements PowerService{
    @Autowired
    private PowerMapper powerMapper;

    @Override
    public Page<Power> selectAll(String title, Integer typeId, String remark, Boolean status) {
        return powerMapper.selectAll(title,  typeId,  remark,  status);
    }

    @Override
    public List<Power> selectAll2() {
        return powerMapper.selectAll2();
    }

    @Override
    public Power selectById(int id) {
        return powerMapper.selectById(id);
    }

    @Override
    public int insert(Power power) {
        return powerMapper.insert(power);
    }

    @Override
    public int update(Power power) {
        return powerMapper.update(power);
    }

    @Override
    public int updateStatus(Integer id, Boolean status) {
        return powerMapper.updateStatus(id,status);
    }

    @Override
    public int delete(int id) {
        return powerMapper.del(id);
    }
}
