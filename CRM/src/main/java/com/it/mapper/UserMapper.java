package com.it.mapper;

import com.github.pagehelper.Page;
import com.it.entity.User;
import org.apache.ibatis.annotations.*;
import org.apache.ibatis.jdbc.SQL;
import org.springframework.util.StringUtils;

import java.util.List;
import java.util.Map;

public interface UserMapper {
    //登录
    @Select("select * from user where login=#{login}")
    User login(String login);

    //分页模糊查询
    @SelectProvider(type = ProviderSelectUser.class,method = "builderSQL")
    @Results({
            @Result(column = "ROLEID",property = "roleId"),
            @Result(column = "ROLEID",property = "role",
            one = @One(select = "com.it.mapper.RoleMapper.selectById"))
    })
    Page<User> selectAll(@Param("name") String name, @Param("status") Boolean status);
    class  ProviderSelectUser{
       public String builderSQL(Map<String,Object> map){
            SQL sql = new SQL();
            String name = (String) map.get("name");
            Boolean status = (Boolean)map.get("status");
            sql.SELECT("id,name,login,password,roleId,status");
            sql.FROM("user");
            if(!StringUtils.isEmpty(name)){
                sql.AND();
                sql.WHERE("'name' like CONCAT('%',#{name},'%') OR login like CONCAT('%',#{name},'%')");
            }
            if(status!=null){
                sql.AND();
                sql.WHERE("status=#{status}");
            }
            return sql.toString();
        }
    }
    //查出启用的用户
    @Select("select id,name from user where status=true")
    List<User> selectAll2();

    //按用户名查找
    @Select("select id from user where name like CONCAT ('%',#{name},'%')")
    User selectByName(String name);

    //删除用户
    @Delete("delete from user where id=#{id}")
    int del(int id);

    //单个查询用户
    @Select("select * from user where id = #{id}")
    User selectById(int id);

    //新增用户
    @Insert("insert into user(name,login,password,roleId) values(#{name},#{login},#{password},#{roleId})")
    int add(User user);

    //修改用户
    @Update("update user set name=#{name},roleId=#{roleId} where id = #{id}")
    int update(User user);

    //修改状态
    @Update("update user set status =NOT status where id=#{id}")
    int updateStatus(int id);

    //修改用户密码
    @Update("update user set password=#{password} where id=#{id}")
    int updatePassword(@Param("id") int id,
                       @Param("password") String password);

    //按客户经理查询用户
    @Select("select user.id as id,user.name as name from `user` INNER JOIN role on user.roleId = role.id where role.id = 3 or role.id = -1")
    List<User> selectByRoleName();
}
