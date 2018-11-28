package com.it.service;

import com.github.pagehelper.Page;
import com.it.entity.Role;
import org.springframework.util.StringUtils;

import java.util.List;

public interface RoleService {
    Page<Role> selectAll(String name, String remark, Boolean status);

    List<Role> selectAll2();

    Role selectById(Integer id);

    int update(Role role);

    int updateStatus(Integer id,Boolean status);

    int add(Role role);

    int del(Integer id);
}
