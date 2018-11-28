package com.it.mapper;

import com.github.pagehelper.Page;
import com.it.entity.Service;
import org.apache.ibatis.annotations.*;
import org.apache.ibatis.jdbc.SQL;
import org.springframework.util.StringUtils;

import java.util.Date;
import java.util.Map;

public interface ServiceMapper {
    @SelectProvider(type = Povider.class,method = "buidSelectSQL")
    Page<Service> selectAll(
            @Param("userId") Integer userId,
            @Param("customerId") String customerId,
            @Param("title") String title,
            @Param("type") String type,
            @Param("status") Integer status,
            @Param("name") String name,
            @Param("date1") Date date1,
            @Param("date2") Date date2
    );

    @SelectProvider(type = Povider.class,method="buidSelectSQL2")
    Page<Service> selectAll2(
            @Param("userId") Integer userId,
            @Param("customerId") String customerId,
            @Param("title") String title,
            @Param("type") String type,
            @Param("status") Integer status,
            @Param("name") String name,
            @Param("date1") Date date1,
            @Param("date2") Date date2
    );


    class Povider{
        public String buidSelectSQL(Map<String,Object> map){
            SQL sql = new SQL();
            String customerId = (String )map.get("customerId");
            String title = (String) map.get("title");
            String type = (String) map.get("type");
            String name = (String) map.get("name");
            Integer status = (Integer) map.get("status");
            Date date1 = (Date) map.get("date1");
            Date date2 = (Date) map.get("date2");
            sql.SELECT("SERVICE.*,c.`name` as cuName");
            sql.FROM("SERVICE");
            sql.INNER_JOIN("customer c on service.customerId = c.id");
            if(!StringUtils.isEmpty(customerId)){
                sql.OR();
                sql.WHERE("c.id=#{customerId}");
            }
            if(!StringUtils.isEmpty(name)){
                sql.OR();
                sql.WHERE("c.name LIKE CONCAT ('%',#{name},'%')");
            }
            if(!StringUtils.isEmpty(title)){
                sql.OR();
                sql.WHERE("title LIKE CONCAT ('%',#{title},'%')");
            }
            if(!StringUtils.isEmpty(type)){
                sql.OR();
                sql.WHERE("type=#{type}");
            }
            if(status != null){
                sql.OR();
                sql.WHERE("SERVICE.status=#{status}");
            }
            if(date1 != null && date2 != null){
                sql.OR();
                sql.WHERE("creationTime BETWEEN #{date1} and #{date2}");
            }
            sql.AND();
            sql.WHERE("creationUserId=#{userId} or assignUserId=#{userId}");
            sql.AND();
            sql.WHERE("SERVICE.status=0 or SERVICE.status=1");
            sql.ORDER_BY("SERVICE.status");
            return sql.toString();
        }


        public String buidSelectSQL2(Map<String,Object> map){
            SQL sql = new SQL();
            String customerId = (String )map.get("customerId");
            String title = (String) map.get("title");
            String type = (String) map.get("type");
            String name = (String) map.get("name");
            Integer status = (Integer) map.get("status");
            Date date1 = (Date) map.get("date1");
            Date date2 = (Date) map.get("date2");


            sql.SELECT("SERVICE.*,c.`name` as cuName");
            sql.FROM("SERVICE");
            sql.INNER_JOIN("customer c on service.customerId = c.id");
            if(!StringUtils.isEmpty(customerId)){
                sql.OR();
                sql.WHERE("c.id=#{customerId}");
            }
            if(!StringUtils.isEmpty(name)){
                sql.OR();
                sql.WHERE("c.name LIKE CONCAT ('%',#{name},'%')");
            }
            if(!StringUtils.isEmpty(title)){
                sql.OR();
                sql.WHERE("title LIKE CONCAT ('%',#{title},'%')");
            }
            if(!StringUtils.isEmpty(type)){
                sql.OR();
                sql.WHERE("type=#{type}");
            }
            if(status != null){
                sql.OR();
                sql.WHERE("SERVICE.status=#{status}");
            }
            if(date1 != null && date2 != null){
                sql.OR();
                sql.WHERE("creationTime BETWEEN #{date1} and #{date2}");
            }
            sql.AND();
            sql.WHERE("creationUserId=#{userId} or assignUserId=#{userId}");
            sql.AND();
            sql.WHERE("SERVICE.status=2 or SERVICE.status=3");
            return sql.toString();
        }
    }

    //分配
    @Update("UPDATE service SET assignUserId=#{userId},assignTime=CURRENT_TIMESTAMP(),`STATUS`=1 " +
            "WHERE ID=#{id}")
    int assign(@Param("id") Integer id,@Param("userId") Integer userId);

    @Select("SELECT SERVICE.*,c.`name` as cuName FROM SERVICE INNER JOIN customer c on SERVICE.customerId=c.id where SERVICE.ID=#{id}")
    Service selectById(int id);

    //归档
    @Update("update SERVICE set status=#{status} where id=#{id}")
    int update(@Param("id") Integer id,@Param("status") Integer status);

    @Delete("DELETE FROM SERVICE WHERE ID=#{id}")
    int delete(int id);

    @Insert("INSERT INTO SERVICE(type,title,customerId,status,request,creationUserId,creationTime) " +
            " values(#{type},#{title},#{customerId},default,#{request},#{creationUserId},#{creationTime})")
    int insert(Service service);



}


