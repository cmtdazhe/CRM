package com.it.service.serviceImpl;

import com.github.pagehelper.Page;
import com.it.entity.Role;
import com.it.mapper.RoleMapper;
import com.it.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RoleServiceImpl implements RoleService{
    @Autowired
    private RoleMapper roleMapper;

    @Override
    public Page<Role> selectAll(String name, String remark, Boolean status) {
        return roleMapper.selectAll(name,remark,status);
    }

    @Override
    public List<Role> selectAll2() {
        return roleMapper.selectAll2();
    }

    @Override
    public Role selectById(Integer id) {
        return roleMapper.selectById(id);
    }

    @Override
    public int add(Role role) {
        return roleMapper.add(role);
    }

    @Override
    public int update(Role role) {
        return roleMapper.update(role);
    }

    @Override
    public int updateStatus(Integer id, Boolean status) {
        return roleMapper.updateStatus(id,status);
    }

    @Override
    public int del(Integer id) {
        return roleMapper.del(id);
    }
}
