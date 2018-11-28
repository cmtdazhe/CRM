<%@ page language="java" pageEncoding="utf-8" contentType="text/html;charset=UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="modal-header">
    <button class="close" data-dismiss="modal">
        <span class="glyphicon glyphicon-remove"></span>
    </button>
    <h3 class="modal-title">
        查看服务信息
        <div class="visible-xs"></div>
        <small>${service.cuName}</small>
    </h3>
</div>

<div class="modal-body">
    <table class="table table-condensed">
        <tr>
            <th class="bg-info" align="right">客户名称</th>
            <td>${service.cuName}</td>
            <th class="bg-info" align="right">概要</th>
            <td>${service.title}</td>
        </tr>
        <tr>
            <th class="bg-info" align="right">类型</th>
            <td>${service.type}</td>
            <th class="bg-info" align="right">分配状态</th>
            <td>
                <span class="text-success">${service.status eq 0 ?'未分配':'已分配'}</span>
            </td>
        </tr>
        <tr>
            <th class="bg-info" align="right">分配人员</th>
            <td>${user.name}</td>
            <th class="bg-info" align="right">分配时间</th>
            <td>
                <div class="visible-xs"></div>
                <f:formatDate value="${service.assignTime}" var="time" pattern="yyyy-MM-dd HH:mm:ss"/>
                ${time}
            </td>
        </tr>
    </table>
    <hr/>
    <table class="table table-hover table-condensed">
        <caption>服务处理情况：</caption>
        <thead>
        <tr class="bg-info">
            <th>时间</th>
            <th>处理详细</th>
            <th>处理结果</th>
            <th>满意度</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${serviceProcesses}" var="ser">
            <f:formatDate value="${ser.creationTime}" var="createDate" pattern="yyyy/MM/dd HH:mm:ss"/>
            <tr>
                <td>${createDate}</td>
                <td>${ser.process}</td>
                <td>${ser.result}</td>
                <td>
                    <div class="text-success">
                            ${ser.satisfy}
                    </div>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<div class="modal-footer">
    <button class="btn btn-default" type="button" data-dismiss="modal">
        <span class="glyphicon glyphicon-remove"></span>
        关闭
    </button>
</div>