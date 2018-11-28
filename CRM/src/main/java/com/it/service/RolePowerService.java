package com.it.service;

import com.it.entity.Power;
import com.it.entity.PowerType;

import java.util.List;

public interface RolePowerService {
    //查询并返回系统中所有的权限类别
    List<PowerType> selectAll();

    //查询指定角色已拥有的权限信息
    List<Power> selectByRoleId(int roleId);

    //为指定角色分配指定的权限
    int assign(int roleId, int[] powerIds);
}

