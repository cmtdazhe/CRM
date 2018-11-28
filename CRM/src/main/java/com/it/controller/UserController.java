package com.it.controller;


import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.it.entity.PowerType;
import com.it.entity.Role;
import com.it.entity.User;
import com.it.service.RoleService;
import com.it.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@Controller
public class UserController {

    @Autowired
    private UserService userService;
    @Autowired
    private RoleService roleService;

    @RequestMapping(value = "/do-login",method = RequestMethod.POST)
    public String login(String login, String password, HttpSession session, Map map){
        User user = userService.login(login);
        String excption="";
        if(user==null){
            //throw new RuntimeException("账号错误");
            excption="用户名错误";
            map.put("login_error",excption);
        }else if (!user.getPassword().equals(password)){
            excption="密码错误";
            map.put("login_error",excption);
        }else if (!user.getStatus()){
            excption="用户禁止登录";
            map.put("login_error",excption);
        }else {
            session.setAttribute("user",user);
            List<PowerType> pts = userService.selectPowersByUser(user);

            session.setAttribute("pts",pts);
            return "redirect:/html/index.jsp";
        }
        return  "/index.jsp";
    }
    //退出登录
    @RequestMapping("/html/login-off")
    public String loginOff(HttpSession session){
        session.invalidate();
        return "redirect:/index.jsp";
    }

    @RequestMapping("/html/~user/users")
    public String selectAll(@RequestParam(required = false) String name,
                            @RequestParam(required = false) Integer statusOne,
                            @RequestParam(required = false)  Integer page,
                            @RequestParam(required = false) Integer pageSize,
                            @RequestParam(required = false) String option_type,
                            HttpSession session){

        if (StringUtils.isEmpty(option_type)) { //不是表单提交
            name = (String) session.getAttribute("user_name");
            statusOne = (Integer) session.getAttribute("user_status");
        } else {
            page = (Integer) session.getAttribute("user_page");
            pageSize = (Integer) session.getAttribute("user_pageSize");
        }

        Boolean status  = null;
        if (statusOne!=null){
            if (statusOne==1){
                status=false;
            }else if(statusOne==0){
                status=true;
            }
        }
        Page<User> users = userService.selectAll(name, status);

        PageInfo<User> pageInfo = new PageInfo<>(users);
        page = (page==null)?1:page;
        pageSize = (pageSize==null)?5:pageSize;
        PageHelper.startPage(page,pageSize);

        session.setAttribute("pageInfos",pageInfo);
        List<Role> roles = roleService.selectAll2();
        session.setAttribute("roles",roles);
        session.setAttribute("user_name",name);
        session.setAttribute("user_stauts",statusOne);
        session.setAttribute("user_page",page);
        session.setAttribute("user_pageSize",pageSize);
        if (pageInfo.getPages() > 0) {
            if (pageInfo.getPageNum() > pageInfo.getPages()
                    || pageInfo.getPageNum() <= 0) {
                session.setAttribute("user_page", 1);
                return "redirect:/html/~user/users";
            }
        }
        return "/html/~user/user.jsp";
    }

    //添加用户
    @RequestMapping("/html/~user/add")
    public String add(User user,HttpSession session){
        userService.add(user);
        Integer page = (Integer) session.getAttribute("user_page");
        if(page == null) {
            page = 1;
        }
        return "redirect:/html/~user/users?page="+page;
    }

    @RequestMapping("/html/~user/to-edit-{id}")
    public String toEdit(@PathVariable int id, Map<String,Object> map){
        User user = userService.selectById(id);
        map.put("user",user);
        return "/html/~user/edit.jsp";
    }

    @RequestMapping("/html/~user/edit")
    public String edit(User user,HttpSession session){
        userService.update(user);
        Integer page = (Integer) session.getAttribute("user_page");
        if(page == null) {
            page = 1;
        }
        return "redirect:/html/~user/users?page="+page;
    }


    //删除
    @RequestMapping("/html/~user/del-{id}")
    public String del(@PathVariable int id,HttpSession session){
        userService.del(id);
        Integer page = (Integer) session.getAttribute("user_page");
        if(page == null) {
            page = 1;
        }
        return "redirect:/html/~user/users?page="+page;
    }


    //改状态
    @RequestMapping("/html/~user/updataStatus-{id}")
    public String updateStatus(@PathVariable int id,HttpSession session){
        userService.updateStatus(id);
        return "redirect:/html/~user/users";
    }
}
