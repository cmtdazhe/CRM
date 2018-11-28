package com.it.mapper;

import com.github.pagehelper.Page;
import com.it.entity.Role;
import org.apache.ibatis.annotations.*;
import org.apache.ibatis.jdbc.SQL;
import org.springframework.util.StringUtils;

import java.util.List;
import java.util.Map;

public interface RoleMapper {
    @SelectProvider(type = RoleMapperSelectAll.class,method = "buliSelectRoleSQL")
    Page<Role> selectAll(
            @Param("name") String name,
            @Param("remark") String remark,
            @Param("status") Boolean status);
    class RoleMapperSelectAll{
        public String buliSelectRoleSQL(Map<String,Object> map){
            SQL sql = new SQL();
            String name = (String) map.get("name");
            String remark = (String) map.get("remark");
            Boolean status = (Boolean) map.get("status");

            sql.SELECT("id,name,remark,status");
            sql.FROM("role");
            if(!StringUtils.isEmpty(name)){
                sql.AND();
                sql.WHERE("name like CONCAT ('%',#{name},'%')");
            }
            if(!StringUtils.isEmpty(remark)){
                sql.AND();
                sql.WHERE("remark like CONCAT ('%',#{remark},'%')");
            }
            if(status!=null){
                sql.AND();
                sql.WHERE("status = #{status}");
            }
            return sql.toString();
        }
    }


    @Select("select * from role")
    List<Role> selectAll2();

    @Select("select * from role where id=#{id}")
    Role selectById(Integer id);

    @Update("update role set name=#{name},remark=#{remark} where id=#{id}")
    int  update(Role role);

    @Update("update role set status=#{status} where id=#{id}")
    int updateStatus(@Param("id") Integer id,@Param("status") Boolean status);

    @Insert("insert into role(name,remark,status) values(#{name},#{remark},#{status})")
    int add(Role role);

    @Delete("delete from role where id=#{id}")
    int del(Integer id);
}
