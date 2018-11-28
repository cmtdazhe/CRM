package com.it.service.serviceImpl;

import com.it.entity.Power;
import com.it.entity.PowerType;
import com.it.mapper.PowerMapper;
import com.it.mapper.PowerTypeMapper;
import com.it.mapper.RolePowerMapper;
import com.it.service.PowerService;
import com.it.service.RolePowerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

@Service
public class RolePowerServiceImpl implements RolePowerService {
    @Autowired
    private RolePowerMapper rolePowerMapper;
    @Autowired
    private PowerMapper powerMapper;
    @Autowired
    private PowerTypeMapper powerTypeMapper;

    @Override
    public List<PowerType> selectAll() {
        //查所有权限，根据typeid的到父类类别
        List<Power> powers = powerMapper.selectAll2();
        List<PowerType> powerTypes = new ArrayList<>();

        for (Power p : powers) {
            Integer typeId = p.getTypeId();
            PowerType pt;
            if (typeId == null) {
                pt = new PowerType();
                pt.setId(Integer.MAX_VALUE);
                pt.setName("未设置");
            } else {
                //查出类别
                pt = powerTypeMapper.selectById(typeId);
            }
            //去除重复查出来的类别
            if (powerTypes.contains(pt)) {
                int i = powerTypes.indexOf(pt);
                powerTypes.get(i).getPowers().add(p);
            } else {
                pt.getPowers().add(p);
                powerTypes.add(pt);
            }
        }
        Collections.sort(powerTypes);
        return powerTypes;
    }

    @Override
    public List<Power> selectByRoleId(int roleId) {
        return rolePowerMapper.selectByRole(roleId);
    }

    @Override
    public int assign(int roleId, int[] powerIds) {
        int result = 0;
        result+=rolePowerMapper.deleteByRole(roleId);
        for (int powerId:powerIds){
            result+=rolePowerMapper.add(roleId,powerId);
        }
        return result;
    }
}

