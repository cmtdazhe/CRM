package com.it.service;

import com.github.pagehelper.Page;
import com.it.entity.PowerType;
import com.it.entity.User;

import java.util.List;

public interface UserService {

    Page<User> selectAll(String name, Boolean status);

    User selectById(int id);
    //添加用户
    int add(User user);

    int update(User user);

    int updateStatus(int id);

    //改默认密码
    int updatePassword(User user);

    int del(int id);

    User login(String login);

    //查权限
    List<PowerType> selectPowersByUser(User user);

    List<User> selectAll2();

    User selectByName(String name);

    List<User> selectByRoleName();
}
