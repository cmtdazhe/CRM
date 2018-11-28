package com.it.controller;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.it.entity.SalesOpportunity;
import com.it.entity.SalesPlan;
import com.it.entity.User;
import com.it.service.SalesOpportunityService;
import com.it.service.SalesPlanService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Controller
public class SalesPlanController {
    @Autowired
    SalesOpportunityService salesOpportunityService;
    @Autowired
    SalesPlanService salesPlanService;

    @RequestMapping("/html/~sale/devs")
    public String salePlans(@RequestParam(required = false) String customerName,
                            @RequestParam(required = false) String title,
                            @RequestParam(required = false) String linkman,
                            @RequestParam(required = false) Integer page,
                            @RequestParam(required = false) Integer pageSize,
                            @RequestParam(required = false) String option_type,
                            Map<String,Object> map,
                            HttpSession session){
        if (StringUtils.isEmpty(option_type)) { //不是表单提交
            customerName = (String) session.getAttribute("dev_customerName");
            title = (String) session.getAttribute("dev_title");
            linkman = (String) session.getAttribute("dev_linkman");
        } else {
            page = (Integer) session.getAttribute("dev_page");
            pageSize = (Integer) session.getAttribute("dev_pageSize");
        }
        page = (page==null)?1:page;
        pageSize = (pageSize==null)?5:pageSize;

        int uid = ((User) session.getAttribute("user")).getId();
        PageHelper.startPage(page,pageSize);
        Page<SalesOpportunity> salesOpportunities = salesOpportunityService.selectAll2(customerName, title, linkman, uid);
        PageInfo<SalesOpportunity> pageInfo = new PageInfo<>(salesOpportunities);
        map.put("pageInfo",pageInfo);
        session.setAttribute("dev_customerName", customerName);
        session.setAttribute("dev_title", title);
        session.setAttribute("dev_linkman", linkman);
        session.setAttribute("dev_page", page);
        session.setAttribute("dev_pageSize", pageSize);
        if (pageInfo.getPages() > 0) {
            if (pageInfo.getPageNum() > pageInfo.getPages()
                    || pageInfo.getPageNum() <= 0) {
                session.setAttribute("dev_page", 1);
                return "redirect:/html/~sale/devs";
            }
        }
        return "/html/~sale/dev.jsp";
    }


    @RequestMapping("/html/~sale/fondDev-{opportunityId}")
    public String selectDev(@PathVariable String opportunityId, Map<String,Object> map){
        SalesOpportunity salesOpportunity = salesOpportunityService.selectById(opportunityId);
        List<SalesPlan> salesPlans = salesPlanService.selectAll(opportunityId);
        map.put("salesPlans",salesPlans);
        map.put("salesOpportunity",salesOpportunity);
        return "/html/~sale/fondDev.jsp";
    }


    //制定计划查询详细信息
    @RequestMapping("/html/~sale/devPlan-{opportunityId}")
    public String devPlan(@PathVariable String opportunityId, Map<String,Object> map){
        SalesOpportunity salesOpportunity = salesOpportunityService.selectById(opportunityId);
        List<SalesPlan> salesPlans = salesPlanService.selectAll(opportunityId);
        map.put("salesPlans",salesPlans);
        map.put("salesOpportunity",salesOpportunity);
        return "/html/~sale/plan.jsp";
    }

    //制定计划
    @RequestMapping(value = "/html/~sale/devPlan-add",method = RequestMethod.POST)
    @ResponseBody
    public SalesPlan planAdd(String opportunityId,String creationTime,String process) throws Exception {
        Date cdt = null;
        if(!StringUtils.isEmpty(creationTime)) {
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            cdt = dateFormat.parse(creationTime.replace('T',' '));;
        }
        SalesPlan salesPlan = new SalesPlan();
        salesPlan.setOpportunityId(opportunityId);
        salesPlan.setCreationTime(cdt);
        salesPlan.setProcess(process);
        salesPlanService.insertProcess(salesPlan);
        return salesPlan;
    }

    //删除一个计划
    @RequestMapping("/html/~sale/dev-del-plan-{id}")
    @ResponseBody
    public int del(@PathVariable int id){
        return salesPlanService.delProcess(id);
    }



    //修改状态
    @RequestMapping("/html/~sale/edit-status")
    public String editStatus(int status,String id){
        salesOpportunityService.updateStatus(status,id);
        return "/html/~sale/devs";
    }
}

