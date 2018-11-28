package com.it.mapper;

import com.github.pagehelper.Page;
import com.it.entity.LostCustomer;
import org.apache.ibatis.annotations.*;
import org.apache.ibatis.jdbc.SQL;
import org.springframework.util.StringUtils;

import java.util.Date;
import java.util.Map;

public interface LostCustomerMapper {
    //根据客户编号查询  客户流失管理
    @SelectProvider(type =LostCustomerSelectProvider.class,method = "buildSelectSQL")
    Page<LostCustomer> selectAll(
            @Param("customerId") String customerId,
            @Param("status") Integer status,
            @Param("cName") String cName);
    class LostCustomerSelectProvider{
        public String buildSelectSQL(Map params){
            String customerId = (String) params.get("customerId");
            String cName = (String) params.get("cName");
            Integer status = (Integer) params.get("status");
            SQL sql = new SQL();
            sql.SELECT("l.id,l.customerId,l.userId,l.lastOrderDate,l.lostDate,l.lostCause,l.status,u.name as uName,c.`name` as cName");
            sql.FROM("LostCustomer l");
            sql.INNER_JOIN("user u on l.userId = u.id");
            sql.INNER_JOIN("customer c on c.id = l.customerId");
            if(!StringUtils.isEmpty(customerId)){
                sql.OR();
                sql.WHERE("l.customerId like CONCAT ('%',#{customerId},'%')");
            }
            if (status!=null){
                if (status!=0){
                sql.OR();
                sql.WHERE("l.status=#{status}");
                }
            }
            if(!StringUtils.isEmpty(cName)){
                sql.OR();
                sql.WHERE("c.name like CONCAT ('%',#{cName},'%')");
            }
            sql.AND();
            sql.WHERE("l.status<>0");
            return sql.toString();
        }
    }


    @Update("update LostCustomer set status=0 where customerId=#{id}")
    int updateStatus(
            @Param("id") String id);
    //暂缓。。等于1预警
    @Update("update LostCustomer set status=2 where customerId=#{id}")
    int updateStatus1(
            @Param("id") String id);

    @Delete("delete from LostCustomer where customerId=#{id}")
    int del(String id);

}
