package com.it.mapper;

import com.it.entity.PowerType;
import org.apache.ibatis.annotations.*;

import java.util.List;

public interface PowerTypeMapper {

    @Select("select id,name from powerType")
    List<PowerType> selectAll();

    @Select("select id,name from powerType where id = #{id}")
    PowerType selectById(int id);

    @SelectKey(before=true,
            keyColumn="id",
            keyProperty="id",
            resultType=Integer.class,
            statement="select max(id)+1 from powertype")
    @Insert("insert into powerType values(#{id},#{name})")
    int insert(PowerType powerType);

    @Update("update powerType set name=#{name} where id=#{id}")
    int update(PowerType powerType);

    @Delete("delete from powerType where id=#{id}")
    int delete(int id);
}

