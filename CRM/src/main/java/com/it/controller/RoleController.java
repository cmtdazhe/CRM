package com.it.controller;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.it.entity.Role;
import com.it.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;

@Controller
public class RoleController {

    @Autowired
    private RoleService roleService;

    @RequestMapping("/html/~role/roles")
    public String selectAll(@RequestParam(required = false) String name,
                            @RequestParam(required = false) String remark,
                            @RequestParam(required = false) Integer statusOne,
                            @RequestParam(required = false) Integer page,
                            @RequestParam(required = false) Integer pageSize,
                            @RequestParam(required = false) String option_type,
                            HttpSession session){
        session.setAttribute("role_name",name);
        session.setAttribute("role_remark",remark);
        session.setAttribute("role_status",statusOne);
        session.setAttribute("role_page",page);
        session.setAttribute("role_pageSize",pageSize);

        if (StringUtils.isEmpty(option_type)) { //不是表单提交
            name = (String) session.getAttribute("role_name");
            remark = (String) session.getAttribute("role_remark");
            statusOne = (Integer) session.getAttribute("role_status");
        } else {
            page = (Integer) session.getAttribute("role_page");
            pageSize = (Integer) session.getAttribute("role_pageSize");
        }
        page = (page==null)?1:page;
        pageSize = (pageSize==null)?5:pageSize;
        PageHelper.startPage(page,pageSize);
        Boolean status = null;
        if(statusOne!=null) {
            if (statusOne == 1) {
                status = false;
            } else if (statusOne == 0) {
                status = true;
            }
        }
        Page<Role> roles = roleService.selectAll(name, remark, status);
        PageInfo<Role> pageInfo = new PageInfo<>(roles);
        session.setAttribute("pageInfo",pageInfo);
        if (pageInfo.getPages() > 0) {
            if (pageInfo.getPageNum() > pageInfo.getPages()
                    || pageInfo.getPageNum() <= 0) {
                session.setAttribute("role_page", 1);
                return "redirect:/html/~role/roles";
            }
        }
        return "/html/~role/role.jsp";
    }

    @RequestMapping("/html/~role/add")
    public String add(Role role,HttpSession session){
        role.setStatus(true);
        roleService.add(role);
        Integer page = (Integer) session.getAttribute("role_page");
        if(page == null) {
            page = 1;
        }
        return "redirect:/html/~role/roles?page="+page;
    }

    @RequestMapping("/html/~role/to-edit-{id}")
    public @ResponseBody Role toEdit(@PathVariable int id){
        return roleService.selectById(id);
    }

    @RequestMapping("/html/~role/edit")
    public String edit(Role role,HttpSession session){
        roleService.update(role);
        Integer page = (Integer) session.getAttribute("role_page");
        if(page == null) {
            page = 1;
        }
        return "redirect:/html/~role/roles?page="+page;
    }

    @RequestMapping("/html/~role/updateStatus-{id}")
    public String updateStatus(@PathVariable int id,HttpSession session){
        Role role = roleService.selectById(id);
         boolean status= !role.getStatus();
         role.setStatus(status);
         roleService.updateStatus(id,status);
         Integer page = (Integer) session.getAttribute("role_page");
         if(page == null){
             page = 1;
         }
        return "redirect:/html/~role/roles?page="+page;
    }

    @RequestMapping("/html/~role/del-{id}")
    public String del(@PathVariable int id,HttpSession session){
        roleService.del(id);
        Integer page = (Integer) session.getAttribute("role_page");
        if(page == null) {
            page = 1;
        }
        return "redirect:/html/~role/roles?page="+page;
    }

}
