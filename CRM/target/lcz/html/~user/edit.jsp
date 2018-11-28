<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="modal-header">
    <div class="h3">
        <span class="glyphicon glyphicon-edit"></span> 编辑角色信息
        <small>${user.name}</small>
    </div>
</div>
<div class="modal-body">
    <form id="form-edit" action="/html/~user/edit" class="form-horizontal" method="post">
        <input type="hidden" value="${user.id}" name="id"/>
        <div class="form-group">
            <label class="col-xs-3 control-label">登录名：</label>
            <div class="col-xs-9">
                <input class="form-control" readonly="readonly" value="${user.login}"/>
            </div>
        </div>
        <div class="form-group">
            <label class="col-xs-3 control-label">姓名：</label>
            <div class="col-xs-9">
                <input class="form-control" name="name" value="${user.name}"/>
            </div>
        </div>
        <div class="form-group">
            <label class="col-xs-3 control-label">标志：</label>
            <c:if test="${user.status==true}">
            <div class="col-xs-9">
                <div class="form-control-static text-success">
                    <span class="glyphicon glyphicon-ok"></span>
                    <span>启用</span>
                </div>
            </div>
            </c:if>
            <c:if test="${user.status==false}">
            <div class="col-xs-9">
                <div class="form-control-static text-danger">
                    <span class="glyphicon glyphicon-remove"></span>
                    <span>禁用</span>
                </div>
            </div>
            </c:if>
        </div>
        <div class="form-group">
            <label class="col-xs-3 control-label">角色：</label>
            <div class="col-xs-9">
                <select class="form-control" name="roleId">
                    <option value="">暂不指定</option>
                    <c:forEach items="${sessionScope.roles}" var="role">
                    <option value="${role.id}" ${role.id eq user.roleId?'selected="selected"':''}>${role.name}</option>
                    </c:forEach>
                </select>
            </div>
        </div>
    </form>
</div>
<div class="modal-footer">
    <button class="btn btn-default" data-dismiss="modal">
        <span class="glyphicon glyphicon-remove"></span>
        关闭
    </button>
    <button class="btn btn-primary" form="form-edit">
        <span class="glyphicon glyphicon-edit"></span>
        更新
    </button>
</div>

