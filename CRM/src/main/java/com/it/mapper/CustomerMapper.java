package com.it.mapper;

import com.github.pagehelper.Page;
import com.it.entity.Customer;
import org.apache.ibatis.annotations.*;
import org.apache.ibatis.jdbc.SQL;
import org.springframework.util.StringUtils;

import java.util.List;
import java.util.Map;

public interface CustomerMapper {
    @SelectProvider(type = CustomerProvider.class, method = "buildSelectSQL")
    @Results(id = "Customer_user", value = {
            @Result(column = "userId", property = "userId"),
            @Result(column = "userId", property = "user",
                    one = @One(select = "com.it.mapper.UserMapper.selectById"))
    })
    Page<Customer> selectAll(
            @Param("id") String id,
            @Param("name") String name,
            @Param("region") String region,
            @Param("userId") Integer userId,
            @Param("level") String level
    );
    class CustomerProvider {
        public String buildSelectSQL(Map params) {
            String id = (String) params.get("id");
            String name = (String) params.get("name");
            String region = (String) params.get("region");
            Integer userId = (Integer) params.get("userId");
            String level = (String) params.get("level");
            SQL sql = new SQL();
            sql.SELECT("*");
            sql.FROM("customer");
            if (!StringUtils.isEmpty(id)) {
                sql.OR();
                sql.WHERE("id like CONCAT ('%',#{id},'%')");
            }
            if (!StringUtils.isEmpty(name)) {
                sql.OR();
                sql.WHERE("`name` like CONCAT ('%',#{name},'%')");
            }
            if (!StringUtils.isEmpty(region)) {
                sql.OR();
                sql.WHERE("region=#{region}");
            }
            if (!StringUtils.isEmpty(userId)) {
                sql.OR();
                sql.WHERE("userId=#{userId}");
            }
            if (!StringUtils.isEmpty(level)) {
                sql.OR();
                sql.WHERE("`level` = #{level}");
            }
            sql.AND();
            sql.WHERE("status<>1");
            return sql.toString();
        }
    }

    @Results(id = "Customer_users", value = {
            @Result(column = "userId", property = "userId"),
            @Result(column = "userId", property = "user",
                    one = @One(select = "com.it.mapper.UserMapper.selectById"))
    })
    @Select("select * from customer where id=#{id}")
    Customer selectById(String id);

    @Update("update customer set name=#{name},region=#{region},userId=#{userId},credit=#{credit},level=#{level},satisfy=#{satisfy}" +
            ",address=#{address},zip=#{zip},tel=${tel},fax=#{fax},website=#{website},licenceNo=#{licenceNo},chieftain=#{chieftain}" +
            ",bankroll=#{bankroll},turnover=#{turnover},bank=#{bank},bankAccount=#{bankAccount},localTaxNo=#{localTaxNo},nationalTaxNo=#{nationalTaxNo} where id=#{id}")
    int updateCustomer(Customer customer);

    @Select("SELECT * FROM CUSTOMER")
    List<Customer> selectAllCustomer();

    @Update("update customer set status=#{status} where id=#{id}")
    int updateStatus(
            @Param("id") String id,
            @Param("status") Integer status);


}
