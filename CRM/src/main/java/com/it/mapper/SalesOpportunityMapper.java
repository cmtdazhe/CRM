package com.it.mapper;

import com.github.pagehelper.Page;
import com.it.entity.SalesOpportunity;
import org.apache.ibatis.annotations.*;
import org.apache.ibatis.jdbc.SQL;
import org.springframework.util.StringUtils;

import java.util.Map;

public interface SalesOpportunityMapper {
    //查询所有,第一个是按时间顺序模糊查询，第二个是按照已经指派的经行条件查询
    @SelectProvider(type=Provider.class,method = "buildSelectSQL")
    Page<SalesOpportunity> selectAll(
            @Param("customerName") String customerName,
            @Param("title") String title,
            @Param("linkman") String linkman,
            @Param("uid") int uid);

    @SelectProvider(type=Provider.class,method = "buildSelectSQL2")
    Page<SalesOpportunity> selectAll2(
            @Param("customerName") String customerName,
            @Param("title") String title,
            @Param("linkman") String linkman,
            @Param("uid") int uid);
    class Provider{
        public String buildSelectSQL(Map<String,Object> map){
            SQL sql = new SQL();
            String customerName = (String) map.get("customerName");
            String title = (String) map.get("title");
            String linkman = (String) map.get("linkman");
            int uid = (Integer) map.get("uid");

            sql.SELECT("*");
            sql.FROM("SalesOpportunity");

            if(!StringUtils.isEmpty(customerName)){
                sql.OR();
                sql.WHERE("customerName like CONCAT ('%',#{customerName},'%')");
            }
            if(!StringUtils.isEmpty(title)){
                sql.OR();
                sql.WHERE("title like CONCAT ('%',#{title},'%')");
            }
            if(!StringUtils.isEmpty(linkman)){
                sql.OR();
                sql.WHERE("linkman like CONCAT ('%',#{linkman},'%')");
            }
            sql.AND();
            sql.WHERE("(creationUserId=#{uid}) or assignUserId = #{uid}");
            sql.AND();
            sql.WHERE("status = 0");
            sql.ORDER_BY("ASSIGNTIME ASC, CREATIONTIME DESC");
            return sql.toString();
        }

        public String buildSelectSQL2(Map<String,Object> map){
            SQL sql = new SQL();
            String customerName = (String) map.get("customerName");
            String title = (String) map.get("title");
            String linkman = (String) map.get("linkman");
            int uid = (Integer) map.get("uid");

            sql.SELECT("*");
            sql.FROM("SalesOpportunity");
            if(!StringUtils.isEmpty(customerName)){
                sql.OR();
                sql.WHERE("customerName like CONCAT ('%',#{customerName},'%')");
            }
            if(!StringUtils.isEmpty(title)){
                sql.OR();
                sql.WHERE("title like CONCAT ('%',#{title},'%')");
            }
            if(!StringUtils.isEmpty(linkman)){
                sql.OR();
                sql.WHERE("linkman like CONCAT ('%',#{linkman},'%')");
            }
            sql.AND();
            sql.WHERE("assignUserId = #{uid}");
            sql.AND();
            sql.WHERE("status<>0");
            sql.ORDER_BY("status");
            return sql.toString();
        }
    }

    @Select("select s.*,u1.name as creationUserName,u2.name as assignUserName \n" +
            "from salesOpportunity s\n" +
            "INNER JOIN `user` u1 on s.creationUserId = u1.id\n" +
            "INNER JOIN `user` u2 on assignUserId = u2.id\n" +
            "where s.id = #{id}")
    SalesOpportunity selectById(String id);

    @Insert("INSERT INTO SALESOPPORTUNITY(ID,CUSTOMERNAME,SOURCE,TITLE,RATE,LINKMAN,TEL,REMARK,CREATIONUSERID,CREATIONTIME) " +
            "VALUES(#{id},#{customerName},#{source},#{title},#{rate},#{linkman},#{tel},#{remark},#{creationUserId},CURRENT_TIMESTAMP())")
    @SelectKey(keyColumn = "id", keyProperty = "id", before = true, statement = "SELECT NewCustomerId()", resultType = String.class)
    int insert(SalesOpportunity salesOpportunity);


    @Update("update salesOpportunity set assignUserId=#{uid},assignTime=CURRENT_TIMESTAMP(),`STATUS`=1 WHERE ID=#{id}")
    int assign(@Param("id") String id, @Param("uid") int uid);

    @Update("update salesOpportunity set customerName=#{customerName},source=#{source},linkman=#{linkman},rate=#{rate},tel=#{tel},title=#{title},remark=#{remark} where id=#{id}")
    int update(SalesOpportunity salesOpportunity);

    @Delete("delete from salesOpportunity where id = #{id}")
    int delete(String id);

    @Update("update salesOpportunity set status=#{status} where id=#{id}")
    int updateStatus(
            @Param("status") int status,
            @Param("id") String id);
    }
