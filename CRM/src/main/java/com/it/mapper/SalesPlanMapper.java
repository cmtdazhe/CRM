package com.it.mapper;

import com.it.entity.SalesPlan;
import org.apache.ibatis.annotations.*;

import java.util.List;

public interface SalesPlanMapper {

    @Select("select * from SaleSplan where opportunityId = #{opportunityId}")
    List<SalesPlan> selectAll(String opportunityId);

    @SelectKey(before=true,
            keyColumn="id",
            keyProperty="id",
            resultType=Integer.class,
            statement="select max(id)+1 from SaleSplan")
    @Insert("insert into SaleSplan(id,opportunityId,creationTime,process) values(#{id},#{opportunityId},#{creationTime},#{process})")
    int insertProcess(SalesPlan salesPlan);

    @Delete("delete from SaleSplan where id=#{id}")
    int delProcess(int id);

    @Update("update SaleSplan set processTime=#{processTime},result=#{result} where id=#{id}")
    int updateResult(SalesPlan salesPlan);
}
