package com.it.mapper;

import com.it.entity.ServiceProcess;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface ServiceProcessMapper {
    @Select("SELECT * FROM SERVICEPROCESS where serviceId = #{serviceId}")
    List<ServiceProcess> selectAll(Integer serviceId);

    @Insert("INSERT INTO SERVICEPROCESS(serviceId,userId,process,result,satisfy,creationTime) VALUES(#{serviceId},#{userId},#{process},#{result},#{satisfy},#{creationTime})")
    int insert(ServiceProcess serviceProcess);

}

