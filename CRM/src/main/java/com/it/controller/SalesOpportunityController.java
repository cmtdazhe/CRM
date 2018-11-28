package com.it.controller;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.it.entity.SalesOpportunity;
import com.it.entity.User;
import com.it.service.SalesOpportunityService;
import com.it.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@Controller
public class SalesOpportunityController {
    @Autowired
    SalesOpportunityService salesOpportunityService;
    @Autowired
    UserService userService;

    @RequestMapping("/html/~sale/sales")
    public String sales(@RequestParam(required = false) String customerName,
                        @RequestParam(required = false) String title,
                        @RequestParam(required = false) String linkman,
                        @RequestParam(required = false) Integer page,
                        @RequestParam(required = false) Integer pageSize,
                        @RequestParam(required = false) String option_type,
                        Map<String,Object> map,
                        HttpSession session){
        if (StringUtils.isEmpty(option_type)) { //不是表单提交
            customerName = (String) session.getAttribute("SalesOpportunity_customerName");
            title = (String) session.getAttribute("SalesOpportunity_title");
            linkman = (String) session.getAttribute("SalesOpportunity_linkman");
        } else {
            page = (Integer) session.getAttribute("SalesOpportunity_page");
            pageSize = (Integer) session.getAttribute("SalesOpportunity_pageSize");
        }
        page = (page==null)?1:page;
        pageSize = (pageSize==null)?5:pageSize;

        int uid = ((User) session.getAttribute("user")).getId();
        PageHelper.startPage(page,pageSize);
        Page<SalesOpportunity> salesOpportunities = salesOpportunityService.selectAll(customerName, title, linkman, uid);
        PageInfo<SalesOpportunity> pageInfo = new PageInfo<>(salesOpportunities);
        map.put("pageInfo3",pageInfo);
        session.setAttribute("SalesOpportunity_customerName", customerName);
        session.setAttribute("SalesOpportunity_title", title);
        session.setAttribute("SalesOpportunity_linkman", linkman);
        session.setAttribute("SalesOpportunity_page", page);
        session.setAttribute("SalesOpportunity_pageSize", pageSize);
        if (pageInfo.getPages() > 0) {
            if (pageInfo.getPageNum() > pageInfo.getPages()
                    || pageInfo.getPageNum() <= 0) {
                session.setAttribute("SalesOpportunity_page", 1);
                return "redirect:/html/~sale/sales";
            }
        }
        return "/html/~sale/index.jsp";
    }


    @RequestMapping("/html/~sale/users")
    @ResponseBody
    public List<User> selectUser(){
        List<User> users = userService.selectAll2();
        return users;
    }

    //指派，修改状态完事
    @RequestMapping(value = "/html/~sale/assign-sale")
    public String assign(String id, int uid,HttpSession session) {
        salesOpportunityService.assign(id, uid);
        Integer page = (Integer) session.getAttribute("SalesOpportunity_page");
        if(page == null) {
            page = 1;
        }
        return "redirect:/html/~sale/sales?page="+page;
    }


    @RequestMapping(value = "/html/~sale/add-sale",method = RequestMethod.POST)
    public String add(SalesOpportunity salesOpportunity,HttpSession session){
        int uid = ((User) session.getAttribute("user")).getId();
        salesOpportunity.setCreationUserId(uid);
        salesOpportunityService.insert(salesOpportunity);
        return "redirect:/html/~sale/sales";
    }

    //去修改
    @RequestMapping("/html/~sale/to-edit-{id}")
    public String toEdit(@PathVariable String id,Map<String,Object> map){
        SalesOpportunity salesOpportunity = salesOpportunityService.selectById(id);
        map.put("salesOpportunity",salesOpportunity);
        return "/html/~sale/edit-sale.jsp";
    }
    //真正修改
    @RequestMapping("html/~sale/edit")
    public String edit(SalesOpportunity salesOpportunity,HttpSession session){
        salesOpportunityService.update(salesOpportunity);
        Integer page = (Integer) session.getAttribute("SalesOpportunity_page");
        if(page == null) {
            page = 1;
        }
        return "redirect:/html/~sale/sales?page="+page;
    }

    @RequestMapping("/html/~sale/del-sale-{id}")
    public String del(@PathVariable String id,HttpSession session){
        salesOpportunityService.delete(id);
        Integer page = (Integer) session.getAttribute("SalesOpportunity_page");
        if(page == null) {
            page = 1;
        }
        return "redirect:/html/~sale/sales?page="+page;
    }
}
