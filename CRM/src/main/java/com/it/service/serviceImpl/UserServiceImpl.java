package com.it.service.serviceImpl;

import com.github.pagehelper.Page;
import com.it.entity.Power;
import com.it.entity.PowerType;
import com.it.entity.Role;
import com.it.entity.User;
import com.it.mapper.PowerTypeMapper;
import com.it.mapper.RoleMapper;
import com.it.mapper.RolePowerMapper;
import com.it.mapper.UserMapper;
import com.it.service.UserService;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserMapper userMapper;
    @Autowired
    private RoleMapper roleMapper;
    @Autowired
    private PowerTypeMapper powerTypeMapper;
    @Autowired
    private RolePowerMapper rolePowerMapper;

    //默认密码
    @Value("${user.default.password}")
    private String userDefaultPassword;

    //查所有，分页
    @Override
    public Page<User> selectAll(String name, Boolean status) {
        return userMapper.selectAll(name,status);
    }
    //查单个用户
    @Override
    public User selectById(int id) {
        return userMapper.selectById(id);
    }
    //添加用户
    @Override
    public int add(User user) {
        user.setPassword(userDefaultPassword);
        return userMapper.add(user);
    }
    //更新
    @Override
    public int update(User user) {
        return userMapper.update(user);
    }
    //查状态
    @Override
    public int updateStatus(int id) {
        return userMapper.updateStatus(id);
    }
    //改密码
    @Override
    public int updatePassword(User user) {
        return userMapper.updatePassword(user.getId(),userDefaultPassword);
    }
    //删除
    @Override
    public int del(int id) {
        return userMapper.del(id);
    }
    //登录
    @Override
    public User login(String login){
        User user = userMapper.login(login);
        return user;
    }

    @Override
    public List<PowerType> selectPowersByUser(User user) {
        List<PowerType> pts = new ArrayList<>();
        Integer roleId = user.getRoleId();//得到roleid,去查角色
        if(roleId != null) {
            Role role = roleMapper.selectById(roleId);
            if(role != null && role.getStatus()){
                List<Power> powers = rolePowerMapper.selectByRole(roleId);//拥有权限

                for(Power p : powers){
                    PowerType pt = null;
                    if(p.getTypeId()==null){
                        pt = new PowerType();
                        pt.setId(Integer.MAX_VALUE);
                        pt.setName("未分组");
                    }else{
                        pt = powerTypeMapper.selectById(p.getTypeId());
                    }

                    if(pts.contains(pt)){
                        int i = pts.indexOf(pt);
                        pt = pts.get(i);
                    }else{
                        pts.add(pt);
                    }

                    pt.getPowers().add(p);
                }
            }
        }
        Collections.sort(pts);
        return pts;
    }

    public List<User> selectAll2(){
        return userMapper.selectAll2();
    }

    public User selectByName(String name){
        return userMapper.selectByName(name);
    }

    public List<User> selectByRoleName(){
        return userMapper.selectByRoleName();
    }
}