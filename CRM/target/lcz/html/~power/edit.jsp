<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="modal-header">
    <div class="modal-title">
        <span class="glyphicon glyphicon-plus"></span>
        <span>修改权限</span>
    </div>
</div>
<div class="modal-body">
    <form action="/html/~power/update-power" method="post" id="form-edit-power" class="form-horizontal">
        <input type="hidden" name="id" value="${power.id}" />
        <div class="form-group form-group-sm">
            <label class="control-label col-xs-3">标题</label>
            <div class="col-xs-9">
                <input class="form-control" name="title" value="${power.title}" required="required" />
            </div>
        </div>

        <div class="form-group form-group-sm">
            <label class="control-label col-xs-3">类别</label>
            <div class="col-xs-9">
                <select class="form-control" name="typeId">
                    <option value="">未设置</option>
                    <c:forEach var="pt" items="${pts}">
                        <option value="${pt.id}" ${pt.id eq power.typeId? 'selected=selected': ''}>${pt.name}</option>
                    </c:forEach>
                </select>
            </div>
        </div>

        <div class="form-group form-group-sm">
            <label class="control-label col-xs-3">URL</label>
            <div class="col-xs-9">
                <input class="form-control" name="url" value="${power.url}" required="required" />
            </div>
        </div>

        <div class="form-group form-group-sm">
            <label class="control-label col-xs-3">描述</label>
            <div class="col-xs-9">
                <input class="form-control" name="remark" value="${power.remark}" />
            </div>
        </div>

        <div class="form-group form-group-sm">
            <label class="control-label col-xs-3">标志</label>
            <div class="col-xs-9">
                <c:choose>
                    <c:when test="${power.status}">
                        <div class="form-control-static text-success">
                            <span class="glyphicon glyphicon-ok"></span>
                            <span>启用</span>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="form-control-static text-danger">
                            <span class="glyphicon glyphicon-remove"></span>
                            <span>禁用</span>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </form>
</div>

<div class="modal-footer">
    <button class="btn btn-default" data-dismiss="modal">
        <span class="glyphicon glyphicon-remove"></span>
        <span>关闭</span>
    </button>
    <button form="form-edit-power" class="btn btn-primary">
        <span class="glyphicon glyphicon-edit"></span>
        <span>更新</span>
    </button>
</div>
