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
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Controller
public class CustomerController {
    @Autowired
    private CustomerService customerService;
    @Autowired
    private UserService userService;
    @Autowired
    private LinkmanService linkmanService;
    //llllll
    private AssociationService associationService;
    @Autowired
    private LostCustomerService lostCustomerService;

    @RequestMapping("/html/~customer/customers")
    public String selectAll(Map<String ,Object> map,
                            @RequestParam(required = false) String option_type,
                            @RequestParam(required = false) String id,
                            @RequestParam(required = false) String name,
                            @RequestParam(required = false) String region,
                            @RequestParam(required = false) String userName,
                            @RequestParam(required = false) String level,
                            @RequestParam(required = false) Integer page,
                            @RequestParam(required = false) Integer pageSize,
                            HttpSession session
    ){
        if(StringUtils.isEmpty(option_type)){
            id = (String) session.getAttribute("customers_id");
            name = (String) session.getAttribute("customers_name");
            region = (String) session.getAttribute("customers_region");
            userName = (String) session.getAttribute("customers_userName");
            level = (String) session.getAttribute("customers_level");
        }else{
            page = (Integer) session.getAttribute("customers_page");
            pageSize = (Integer) session.getAttribute("customers_pageSize");
        }
        page = (page==null)?1:page;
        pageSize=(pageSize==null)?5:pageSize;
        PageHelper.startPage(page,pageSize);

        Integer userId = null;
        if(!StringUtils.isEmpty(userName)){
            User user = userService.selectByName(userName);
            userId = user.getId();
        }

        Page<Customer> customers = customerService.selectAll(id, name, region, userId, level);
        PageInfo<Customer> pageInfo = new PageInfo<>(customers);

        session.setAttribute("customers_id",id);
        session.setAttribute("customers_name",name);
        session.setAttribute("customers_region",region);
        session.setAttribute("customers_userName",userName);
        session.setAttribute("customers_level",level);
        session.setAttribute("customers_page",page);
        session.setAttribute("customers_pageSize",pageSize);
        map.put("pageInfo4",pageInfo);

        if (pageInfo.getPages() > 0) {
            if (pageInfo.getPageNum() > pageInfo.getPages()
                    || pageInfo.getPageNum() <= 0) {
                session.setAttribute("customers_page", 1);
                return "redirect:/html/~customer/customers";
            }
        }
        return "/html/~customer/customer.jsp";
    }

    @RequestMapping("/html/~customer/customer-show-{id}")
    public String customerShow(@PathVariable String id,Map<String,Object> map){
        Customer customer = customerService.selectById(id);
        map.put("cu",customer);
        return "/html/~customer/customerShow.jsp";
    }

    @RequestMapping("/html/~customer/to-edit-{id}")
    public String toEdit(@PathVariable String id,Map<String,Object> map){
        Customer customer = customerService.selectById(id);
        List<User> users = userService.selectByRoleName();
        map.put("customer",customer);
        map.put("users",users);
        return "/html/~customer/customerEdit.jsp";
    }

    @RequestMapping("/html/~customer/edit")
    public String edit(Customer customer,HttpSession session){
        customerService.updateCustomer(customer);
        Integer page =(Integer) session.getAttribute("customers_page");
        if(page == null) {
            page = 1;
        }
        return "redirect:/html/~customer/customers?page="+page;
    }


    //联系人信息管理
    @RequestMapping("/html/~customer/linkman-{id}")
    public String linkMan(@PathVariable String id,Map<String,Object> map){
        Customer customer = customerService.selectById(id);
        List<Linkman> linkmen = linkmanService.selectByCustomerId(id);
        map.put("Linkcustomer",customer);
        map.put("linkmen",linkmen);
        return "/html/~customer/customerLinkman.jsp";
    }

    @RequestMapping("/html/~customer/to-add-linkman-{id}")
    @ResponseBody
    public Customer toLinkmanAdd(@PathVariable String id){
        Customer customer = customerService.selectById(id);
        return customer;
    }

    @RequestMapping("/html/~customer/addLinkman")
    public @ResponseBody
    Linkman linkManAdd(String customerId, String name, String job, String tel, String sex, String remark) throws UnsupportedEncodingException {
        Linkman linkman = new Linkman();
        name = new String(name.getBytes("iso8859-1"),"utf-8");
        job = new String(job.getBytes("iso8859-1"),"utf-8");
        sex = new String(sex.getBytes("iso8859-1"),"utf-8");
        remark = new String(remark.getBytes("iso8859-1"),"utf-8");
        linkman.setCustomerId(customerId);
        linkman.setName(name);
        linkman.setJob(job);
        linkman.setTel(tel);
        linkman.setSex(sex);
        linkman.setRemark(remark);
        linkmanService.add(linkman);
        return linkman;
    }

    @RequestMapping("/html/~customer/to-edit")
    @ResponseBody
    public Linkman toEdit(Integer id){
        Linkman linkman = linkmanService.selectById(id);
        return linkman;
    }
    @RequestMapping("/html/~cusromer/linkman-edit")
    public @ResponseBody
    Linkman edit(Linkman linkman) {
        linkmanService.update(linkman);
        return linkman;
    }
    @RequestMapping("/html/~cusromer/linkman-del-{id}")
    @ResponseBody
    public int linkManDel(@PathVariable int id){
        return linkmanService.del(id);
    }

    //交往记录模块
    @RequestMapping("/html/~customer/association-{customerId}")
    public String association(@PathVariable String customerId,Map<String,Object> map){
        List<Association> associations = associationService.selectByCustomerId(customerId);
        Customer customer = customerService.selectById(customerId);
        map.put("as",associations);
        map.put("customer",customer);
        return "/html/~customer/customerAssociation.jsp";
    }

    @RequestMapping("/html/~customer/to-add-association-{id}")
    @ResponseBody
    public Customer toAssociationAdd(@PathVariable String id){
        Customer customer = customerService.selectById(id);
        return customer;
    }

    @RequestMapping("/html/~customer/addAssociation")
    public @ResponseBody
    Association AssociationAdd(String customerId, String creationTime, String title, String place, String remark) throws Exception, UnsupportedEncodingException {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date createDate = dateFormat.parse(creationTime);
        title = new String(title.getBytes("iso8859-1"),"utf-8");
        place = new String(place.getBytes("iso8859-1"),"utf-8");
        remark = new String(remark.getBytes("iso8859-1"),"utf-8");
        Association association = new Association();
        association.setCustomerId(customerId);
        association.setCreationTime(createDate);
        association.setPlace(place);
        association.setTitle(title);
        association.setRemark(remark);
        associationService.add(association);
        return association;
    }

    @RequestMapping("/html/~cusromer/association-del-{id}")
    @ResponseBody
    public int associationDel(@PathVariable int id){
        return associationService.del(id);
    }


}


