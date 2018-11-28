<%@ page language="java" pageEncoding="utf-8" contentType="text/html;charset=UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:if test="${pageInfo5==null}">
    <c:redirect url="/html/~customer/lostCustomers"/>
</c:if>
<html>

<head>
    <title>客户关系管理系统-客户流失管理</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />

    <link rel="stylesheet" type="text/css" href="../../css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="../../css/bootstrap-theme.min.css" />
    <link rel="stylesheet" type="text/css" href="../../css/normalize.min.css" />

    <script src="../../js/jquery-3.2.1.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../js/bootstrap.min.js" type="text/javascript" charset="utf-8"></script>

    <!--[if lte IE 8]>
    <script src="../../js/html5shiv.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../js/respond.min.js" type="text/javascript" charset="utf-8"></script>
    <![endif]-->

    <!-- 界面自定义CSS文件 -->
    <link rel="stylesheet" type="text/css" href="../../css/custom/scrollbar-style.min.css" />
    <link rel="stylesheet" type="text/css" href="../../css/custom/html-cust-lost.min.css" />

    <!--界面自定义JS文件-->
<%--    <script src="../../js/custom/tip-popover.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../js/custom/html-cust-lost.js" type="text/javascript" charset="utf-8"></script>--%>
    <script type="text/javascript">
        $(function () {
           $(document).on('click','[data-show-customer]',function () {
              var customerId = $(this).data('show-customer');
              var url = "/html/~customer/to-show-"+customerId;
              $('#modal-show .modal-content').load(url, function () {
                   $('#modal-show').modal('show');
               });
           });


           $(document).on('click','[data-edit-status]',function () {
              var id = $(this).data('edit-status');
               $(this).popover({
                   title: 'zt',
                   html: true,
                   trigger: 'click|focus',
                   placement: 'top',
                   content: function () {
                       var alist = '<div class="list-group">';
                       alist+='<a class="list-group-item" href="/html/~customer/edit-status-'+id+'">'+恢复+'</a>';
                       alist+='<a class="list-group-item" href="/html/~customer/edit-status1-'+id+'">'+暂缓+'</a>';
                       alist+='<a class="list-group-item" href="/html/~customer/del-status-'+id+'">'+流失+'</a>';
                       alist+='</div>';
                       return alist;
                   }
               });
           });
        });
    </script>

</head>

<body>
<div class="container-fluid">

    <!--TODO 当前页面地理位置 (面包屑导航)-->
    <ul class="breadcrumb">
        <li>客户管理</li>
        <li>客户流失管理</li>
    </ul>

    <!--TODO 搜索表单及工具按钮-->
    <form id="form-search" method="post" action="/html/~customer/lostCustomers" class="form-inline">
        <input type="hidden" name="option_type" value="form">
        <div class="form-group">
            <label class="control-label">客户编号：</label>
            <div class="input-group">
                <span class="input-group-addon">CST</span>
                <input class="form-control" type="text" value="${sessionScope.lostCustomers_customerId}" name="customerId"/>
            </div>

            <label class="control-label">名称：</label>
            <input class="form-control" type="text" name="cName" value="${lostCustomers_cName}"/>

            <label class="control-label">状态：</label>
            <select class="form-control" name="status">
                <option value="">全部</option>
                <option class="bg-warning" value="0" ${lostCustomers_status eq 0?'selected="selected"':''}>预警</option>
                <option class="bg-info" value="1" ${lostCustomers_status eq 1?'selected="selected"':''}>暂缓流失</option>
                <option class="bg-danger" value="2" ${lostCustomers_status eq 2?'selected="selected"':''}>确认流失</option>
            </select>
        </div>

        <div class="form-group btn-group">
            <button class="btn btn-default">
                <span class="glyphicon glyphicon-search"></span>
                查询
            </button>
        </div>

    </form>

    <hr />

    <!--TODO 数据列表-->
    <table class="table table-hover table-bordered">
        <thead class="bg-primary">
        <tr>
            <th class="hidden-xs">#</th>
            <th>客户名称</th>
            <th class="hidden-xs">客户经理</th>
            <th class="hidden-xs">活跃截至</th>
            <th>状态时间</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
      <c:forEach items="${pageInfo5.list}" var="l">
        <tr>
            <td class="hidden-xs">${l.customerId}</td>
            <td>${l.cName}</td>
            <td class="hidden-xs">${l.uName}</td>
            <f:formatDate value="${l.lastOrderDate}" var="lastOrderDate" pattern="yyyy/MM/dd"/>
            <td class="hidden-xs">${lastOrderDate}</td>
            <f:formatDate value="${l.lostDate}" var="lostDate" pattern="yyyy-MM/dd"/>
            <td>
                <c:if test="${l.status == 1}">
                    <div class="text-warning">
                        预警
                    <div class="visible-xs"></div>
                        [${lostDate}]
                    </div>
                </c:if>
                <c:if test="${l.status==2}">
                    <div class="text-success">
                        暂缓
                        <div class="visible-xs"></div>
                        [${lostDate}]
                    </div>
                </c:if>
            </td>
            <td>
                <div class="btn-group btn-group-xs">
                    <button class="btn btn-default" data-show-customer="${l.customerId}">
                        <span class="glyphicon glyphicon-search"></span>
                        <span class="hidden-xs">查看</span>
                    </button>
                    <c:if test="${l.status!=0}">
                    <button class="btn btn-default lost-option" data-edit-status="${l.customerId}">
                        <span class="glyphicon glyphicon-cog"></span>
                        <span class="hidden-xs">操作</span>
                    </button>
                    </c:if>
                </div>
            </td>
        </tr>
      </c:forEach>
        </tbody>
    </table>

    <!--TODO 数据分页部分-->
    <div class="text-center">
        <ul class="pagination">
            <li ${pageInfo5.pageNum eq 1?'class="disabled"':''}>
                <a href="/html/~customer/lostCustomers?page=${pageInfo5.prePage}">&lt;</a>
            </li>
            <c:forEach items="${pageInfo5.navigatepageNums}" var="i">
            <li ${i eq pageInfo5.pageNum?'class="active"':''}>
                <a href="/html/~customer/lostCustomers?page=${i}">${i}</a>
            </li>
            </c:forEach>
            <li ${pageInfo5.pages eq pageInfo5.pageNum?'class="disabled"':''}>
                <a   <c:if test="${pageInfo5.pages != pageInfo5.pageNum}">
                    href="/html/~power/powers?page=${pageInfo5.nextPage}"
                </c:if>>&gt;</a>
            </li>
        </ul>
    </div>
</div>

<!-- TODO 查看客户信息modal部分 -->
<div class="modal fade" id="modal-show">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">

        </div>
    </div>
</div>

