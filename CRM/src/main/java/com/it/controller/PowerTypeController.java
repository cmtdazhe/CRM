package com.it.controller;

import com.it.entity.PowerType;
import com.it.service.PowerTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Map;

@Controller
public class PowerTypeController {
    @Autowired
    PowerTypeService powerTypeService;

    @RequestMapping("/html/~power/powertypes")
    public String selectAll(Map<String,Object> map){
        List<PowerType> powerTypes = powerTypeService.selectAll();
        map.put("pts",powerTypes);
        return "/html/~power/powerType.jsp";
    }

    @RequestMapping("/html/~power/powerTypesAdd")
    @ResponseBody
    public PowerType add(PowerType powerType){
        powerTypeService.insert(powerType);
        return powerType;
    }

    @RequestMapping("/html/~power/power-type-del-{id}")
    @ResponseBody
    public int del(@PathVariable int id){
        return powerTypeService.delete(id);
    }

    @RequestMapping("/html/~power/power-type-update")
    @ResponseBody
    public PowerType update(PowerType powerType){
        powerTypeService.update(powerType);
        return powerType;
    }
}

