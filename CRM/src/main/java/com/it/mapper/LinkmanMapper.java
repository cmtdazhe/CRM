package com.it.mapper;

import com.it.entity.Linkman;
import org.apache.ibatis.annotations.*;

import java.util.List;

public interface LinkmanMapper {
    @Select("select * from Linkman  where customerId = #{customerId}")
    List<Linkman> selectByCustomerId(String customerId);

    @Select("select * from Linkman  where id = #{id}")
    Linkman selectById(Integer id);

    //新增联系人
    @SelectKey(before=true,
            keyColumn="id",
            keyProperty="id",
            resultType=Integer.class,
            statement="select max(id)+1 from Linkman")
    @Insert("INSERT INTO `Linkman` VALUES (#{id}, #{customerId},#{name},#{sex},#{job},#{tel},#{remark})")
    int add(Linkman linkman);

    @Update("update `Linkman` set name=#{name},sex=#{sex},job=#{job},tel=#{tel},remark=#{remark} where id=#{id}")
    int update(Linkman linkman);

    @Delete("delete from Linkman where id = #{id}")
    int del(Integer id);
}

