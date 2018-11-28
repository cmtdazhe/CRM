package com.it.controller;


import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.it.entity.Power;
import com.it.entity.PowerType;
import com.it.service.PowerService;
import com.it.service.PowerTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@Controller
public class PowerController {
    @Autowired
    private PowerService powerService;
    @Autowired
    private PowerTypeService powerTypeService;


    @RequestMapping("/html/~power/powers")
    public String selectAll(@RequestParam(required = false) String title,
                            @RequestParam(required = false) Integer typeId,
                            @RequestParam(required = false) String remark,
                            @RequestParam(required = false) Integer statusOne,
                            @RequestParam(required = false) Integer page,
                            @RequestParam(required = false) Integer pageSize,
                            @RequestParam(required = false) String option_type,
                            Map<String,Object> map,
                            HttpSession session){

        session.setAttribute("power_title",title);
        session.setAttribute("power_typeId",typeId);
        session.setAttribute("power_remark",remark);
        session.setAttribute("power_status",statusOne);
        session.setAttribute("power_page",page);
        session.setAttribute("power_pageSize",pageSize);

        if (StringUtils.isEmpty(option_type)){
            title= (String) session.getAttribute("power_title");
            typeId = (Integer) session.getAttribute("power_typeId");
            remark = (String)session.getAttribute("power_remark");
            statusOne = (Integer) session.getAttribute("power_status");
        }else{
            page = (Integer) session.getAttribute("power_page");
            pageSize = (Integer)session.getAttribute("power_pageSize");
        }

        page = (page==null)?1:page;
        pageSize = (pageSize==null)?5:pageSize;
        PageHelper.startPage(page,pageSize);

        Boolean status = null;
        if (statusOne!=null){
            if(statusOne==0){
                status=true;
            }else if (statusOne==1){
                status=false;
            }
        }
        Page<Power> powers = powerService.selectAll(title, typeId, remark, status);
        PageInfo<Power> pageInfo = new PageInfo<>(powers);
        session.setAttribute("pageInfo1",pageInfo);
        List<PowerType> powerTypes = powerTypeService.selectAll();
        map.put("powerTypes",powerTypes);

        if(pageInfo.getPages()>0){
            if (pageInfo.getPageNum()>pageInfo.getPages()||pageInfo.getPageNum()<=0){
                session.setAttribute("power_page",1);
                return "redirect:/html/~power/powers";
            }
        }
        return "/html/~power/power.jsp";
    }

    @RequestMapping("/html/~power/add")
    public String add(Power power, HttpSession session){
        powerService.insert(power);
        Integer page = (Integer) session.getAttribute("power_page");
        if(page == null) {
            page = 1;
        }
        return "redirect:/html/~power/powers?page="+page;
    }


    @RequestMapping("/html/~power/del-{id}")
    public String del(@PathVariable Integer id, HttpSession session){
        int count = powerService.delete(id);
        Integer page = (Integer) session.getAttribute("power_page");
        if(page == null) {
            page = 1;
        }
        return "redirect:/html/~power/powers?page="+page;
    }

    @RequestMapping("/html/~power/updateStatus-{id}")
    public String updateStatus(@PathVariable int id,HttpSession session){
        Power power = powerService.selectById(id);
        boolean status = !power.isStatus();
        power.setStatus(status);
        powerService.updateStatus(id, status);
        Integer page = (Integer) session.getAttribute("power_page");
        if(page == null) {
            page = 1;
        }
        return "redirect:/html/~power/powers?page="+page;
    }

    @RequestMapping("/html/~power/to-edit-{id}")
    public String toEdit(@PathVariable int id,Map<String,Object> map){
        Power power = powerService.selectById(id);
        map.put("power", power);

        List<PowerType> pts = powerTypeService.selectAll();
        map.put("pts", pts);
        return "/html/~power/edit.jsp";
    }

    @RequestMapping("/html/~power/update-power")
    public String edit(Power power,HttpSession session){
        powerService.update(power);
        Integer page = (Integer) session.getAttribute("power_page");
        if(page == null) {
            page = 1;
        }
        return "redirect:/html/~power/powers?page="+page;
    }
}
