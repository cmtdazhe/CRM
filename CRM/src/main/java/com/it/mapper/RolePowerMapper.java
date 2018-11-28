package com.it.mapper;

import com.it.entity.Power;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface RolePowerMapper {
    //根据角色编号查询该角色拥有的权限
    @Select("SELECT * FROM POWER_ROLE " +
            "INNER JOIN POWER ON POWERID = ID " +
            "WHERE ROLEID=#{roleId}")
    List<Power> selectByRole(int roleId);

    @Insert("INSERT INTO POWER_ROLE(ROLEID,POWERID) " +
            "VALUES(#{roleId}, #{powerId})")
    int add(@Param("roleId") int roleId, @Param("powerId") int powerId);

    @Delete("DELETE FROM POWER_ROLE WHERE ROLEID=#{roleId}")
    int deleteByRole(int roleId);
}

