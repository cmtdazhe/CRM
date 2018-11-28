package com.it.controller;


import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.it.entity.*;
import com.it.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Controller
public class LostCustomerController {
    @Autowired
    private LostCustomerService lostCustomerService;
    @Autowired
    private CustomerService customerService;
    @Autowired
    private LinkmanService linkmanService;
    @Autowired
    private AssociationService associationService;

    @RequestMapping("/html/~customer/lostCustomers")
    public String selectAll(Map<String,Object> map,
                            @RequestParam(required = false) String option_type,
                            @RequestParam(required = false) String customerId,
                            @RequestParam(required = false) Integer status,
                            @RequestParam(required = false) String cName,
                            @RequestParam(required = false) Integer page,
                            @RequestParam(required = false) Integer pageSize,
                            HttpSession session){
        if (StringUtils.isEmpty(option_type)) { //不是表单提交
            customerId = (String) session.getAttribute("lostCustomers_customerId");
            status = (Integer) session.getAttribute("lostCustomers_status");
            cName = (String) session.getAttribute("lostCustomers_cName");
        }else{
            page = (Integer) session.getAttribute("lostCustomers_page");
            pageSize = (Integer) session.getAttribute("lostCustomers_pageSize");
        }
        page = (page==null?1:page);
        pageSize = (pageSize==null?5:pageSize);
        PageHelper.startPage(page,pageSize);

        Page<LostCustomer> lostCustomers = lostCustomerService.selectAll(customerId,status,cName);
        PageInfo<LostCustomer> pageInfo = new PageInfo<>(lostCustomers);
        map.put("pageInfo5",pageInfo);
        session.setAttribute("lostCustomers_customerId",customerId);
        session.setAttribute("lostCustomers_status",status);
        session.setAttribute("lostCustomers_cName",cName);
        session.setAttribute("lostCustomers_page",page);
        session.setAttribute("lostCustomers_pageSize",pageSize);
        if (pageInfo.getPages() > 0) {
            if (pageInfo.getPageNum() > pageInfo.getPages()
                    || pageInfo.getPageNum() <= 0) {
                session.setAttribute("lostCustomers_page", 1);
                return "redirect:/html/~customer/lostCustomers";
            }
        }
        return "/html/~customer/lostCustomer.jsp";
    }

    //按ID查询客户信息
    @RequestMapping("/html/~customer/to-show-{customerId}")
    public String showCustomer(@PathVariable String customerId, Map<String,Object> map){
        Customer customer = customerService.selectById(customerId);
        List<Linkman> linkmans = linkmanService.selectByCustomerId(customerId);
        List<Association> associations = associationService.selectByCustomerId(customerId);
        map.put("cu",customer);
        map.put("ln",linkmans);
        map.put("as",associations);
        return "/html/~customer/lostCustomerModal.jsp";
    }


    //修改状恢复
    @RequestMapping("/html/~customer/edit-status-{id}")
    public String editStatus(@PathVariable String id){
        lostCustomerService.updateStatus(id);
        return "/html/~customer/lostCustomers";
    }
    //修改状暂缓
    @RequestMapping("/html/~customer/edit-status1-{id}")
    public String editStatus1(@PathVariable String id){
        lostCustomerService.updateStatus1(id);
        return "/html/~customer/lostCustomers";
    }
    //修改状流失/删除
    @RequestMapping("/html/~customer/del-status-{id}")
    public String del(@PathVariable String id){
        lostCustomerService.del(id);
        return "/html/~customer/lostCustomers";
    }



}

