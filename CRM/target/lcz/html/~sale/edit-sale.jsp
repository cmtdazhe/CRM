<%--
  Created by IntelliJ IDEA.
  User: 李承哲
  Date: 2018/11/8
  Time: 16:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="modal-header">
    <div class="h3">
        <span class="glyphicon glyphicon-edit"></span> 编辑销售机会
        <small>${salesOpportunity.id}</small>
    </div>
</div>

<div class="modal-body">
    <form action="/html/~sale/edit" method="post" id="form-edit" class="form-horizontal">
    <input type="hidden" name="id"/>
        <div class="form-group">
            <label class="col-xs-3 control-label">客户名称</label>
            <div class="col-xs-9">
                <input class="form-control" name="customerName" value="${salesOpportunity.customerName}" required="required" autofocus="autofocus"/>
            </div>
        </div>

        <div class="form-group">
            <label class="col-xs-3 control-label">联系人</label>
            <div class="col-xs-9">
                <input class="form-control" name="linkman" value="${salesOpportunity.linkman}"/>
            </div>
        </div>

        <div class="form-group">
            <label class="col-xs-3 control-label">联系电话</label>
            <div class="col-xs-9">
                <input class="form-control" name="tel" value="${salesOpportunity.tel}" type="tel"/>
            </div>
        </div>

        <div class="form-group">
            <label class="col-xs-3 control-label">概要</label>
            <div class="col-xs-9">
                <textarea class="form-control" name="title" id="title" style="min-height: 50px;"></textarea>
            </div>
        </div>

        <div class="form-group">
            <label class="col-xs-3 control-label">机会来源</label>
            <div class="col-xs-9">
                <input class="form-control" type="text" name="source" value="${salesOpportunity.source}"/>
            </div>
        </div>

        <div class="form-group">
            <label class="col-xs-3 control-label">
                成功概率
                <span class="text-muted" id="range_et_1"></span>
            </label>
            <div class="col-xs-9">
                <input class="form-control-static" type="range" max="100" min="0" name="rate" data-target="#range_et_1" />
            </div>
        </div>

        <div class="form-group">
            <label class="col-xs-3 control-label">描述</label>
            <div class="col-xs-9">
                <textarea class="form-control" name="remark" id="remark" style="min-height: 100px;"></textarea>
            </div>
        </div>
    </form>
</div>

    <div class="modal-footer">
        <button class="btn btn-default" type="button" data-dismiss="modal">
            <span class="glyphicon glyphicon-remove"></span>
            关闭
        </button>
        <button class="btn btn-primary" form="form-edit">
            <span class="glyphicon glyphicon-edit"></span>
            确定
        </button>
    </div>

