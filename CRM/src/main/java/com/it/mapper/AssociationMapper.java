package com.it.mapper;

import com.it.entity.Association;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectKey;

import java.util.List;

public interface AssociationMapper {
    @Select("select * from Association where customerId = #{customerId}")
    List<Association> selectByCustomerId(String customerId);

    @SelectKey(before=true,
            keyColumn="id",
            keyProperty="id",
            resultType=Integer.class,
            statement="select max(id)+1 from Association")
    @Insert("INSERT INTO `Association` VALUES (#{id},#{customerId},#{creationTime},#{place}, #{title},#{remark})")
    int add(Association association);

    @Delete("delete from Association where id=#{id}")
    int del(Integer id);
}

