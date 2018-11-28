package com.it.controller;

import com.it.entity.Power;
import com.it.entity.PowerType;
import com.it.service.RolePowerService;
import com.it.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;
import java.util.Map;

@Controller
public class RolePowerController {
    @Autowired
    RolePowerService rolePowerService;

    @Autowired
    RoleService roleService;

    @RequestMapping("/html/~role/to-assign-{roleId}")
    public String toAssign(@PathVariable int roleId, Map map){

        //系统中所有的权限类别(带powers属性)
        List<PowerType> powerTypes = rolePowerService.selectAll();

        //当前指定编号的角色拥有的所有权限
        List<Power> powers = rolePowerService.selectByRoleId(roleId);

        for(PowerType pt : powerTypes){
            List<Power> powers1 = pt.getPowers();
            for(Power p : powers1){
                if(powers.contains(p))
                    p.setChecked(true);
            }
        }
        map.put("pts", powerTypes);
        map.put("role", roleService.selectById(roleId));

        return "power.jsp";
    }

    @RequestMapping("/html/~role/assign")
    public String assign(int roleId, int[] powers){
        rolePowerService.assign(roleId, powers);
        return "redirect:/html/~role/roles";
    }
}
