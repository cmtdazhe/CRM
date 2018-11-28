package com.it.mapper;

import com.github.pagehelper.Page;
import com.it.entity.Power;
import org.apache.ibatis.annotations.*;
import org.apache.ibatis.jdbc.SQL;
import org.springframework.util.StringUtils;
import java.util.List;
import java.util.Map;

public interface PowerMapper {
    @SelectProvider(type = PowerSelectProvider.class,method = "buildSelectSQL")
    Page<Power> selectAll(@Param("title") String title,
                          @Param("typeId") Integer typeId,
                          @Param("remark") String remark,
                          @Param("status") Boolean status);
    class PowerSelectProvider{
           public String buildSelectSQL(Map<String,Object> map){
                SQL sql = new SQL();
                String title = (String)map.get("title");
                Integer typeId = (Integer)map.get("typeId");
                String remark = (String) map.get("remark");
                Boolean status = (Boolean) map.get("status");

                sql.SELECT("id,title,typeId,url,remark,status");
                sql.FROM("power");
                if(!StringUtils.isEmpty(title)){
                    sql.AND();
                    sql.WHERE("title like CONCAT('%',#{title},'%')");
                }
                if(typeId!=null){
                    if(typeId==0){ // 筛选没有typeId值的权限
                        sql.AND();
                        sql.WHERE("typeId is null");
                    }else if(typeId>0){
                        sql.AND();
                        sql.WHERE("typeId = #{typeId}");
                    }
                }
                if(!StringUtils.isEmpty(remark)){
                    sql.AND();
                    sql.WHERE("remark like CONCAT('%',#{remark},'%')");
                }
                if(status!=null){
                    sql.AND();
                    sql.WHERE("'status' = #{status}");
                }
                return sql.toString();
            }
    }

    @Select("SELECT id,title,typeId,url,remark,`status` FROM power")
    List<Power> selectAll2();

    @Insert("insert into power(title,typeId,url,remark) values(#{title},#{typeId},#{url},#{remark})")
    int insert(Power power);


    @Select("select id,title,typeId,url,remark,status from power where id=#{id}")
    Power selectById(Integer id);

    @Update("update power set title=#{title},typeId=#{typeId},url=#{url},remark=#{remark} where id=#{id}")
    int update(Power power);

    @Update("update power set status=#{status} where id=#{id}")
    int updateStatus(@Param("id") Integer id,
                     @Param("status") Boolean status);

    @Delete("delete from power where id=#{id}")
    int del(int id);
}
