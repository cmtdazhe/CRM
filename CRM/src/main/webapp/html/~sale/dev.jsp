<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:if test="${pageInfo == null}">
    <c:redirect url="/html/~sale/devs"/>
</c:if>
<html>
<head>
    <title>客户关系管理系统-销售机会管理</title>
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
    <link rel="stylesheet" type="text/css" href="../../css/custom/html-sale-dev.min.css" />

    <!--界面自定义JS文件-->
    <script src="../../js/custom/tip-popover.min.js" type="text/javascript" charset="utf-8"></script>
    <%--<script src="../../js/custom/html-sale-dev.js" type="text/javascript" charset="utf-8"></script>--%>
    <script src="../../js/crmJs/sale.js" type="text/javascript" charset="utf-8"></script>
</head>
<body>
    <div class="container-fluid">
        <!--当前页面地理位置 (面包屑导航)-->
        <ul class="breadcrumb">
            <li>营销管理</li>
            <li>客户开发管理</li>
        </ul>

        <!--搜索表单及工具按钮-->
        <form id="form-search" action="/html/~sale/devs" method="post" class="form-inline">
            <input type="hidden" name="option_type" value="form">
            <div class="form-group">
                <label class="control-label">客户名称：</label>
                <input class="form-control" type="text" name="customerName" value="${dev_customerName}"/>

                <label class="control-label">概要：</label>
                <input class="form-control" type="text" name="title" value="${dev_title}"/>

                <label class="control-label">联系人：</label>
                <input class="form-control" type="text" name="linkman" value="${dev_linkman}"/>
            </div>

            <div class="form-group btn-group">
                <button class="btn btn-default">
                    <span class="glyphicon glyphicon-search"></span>
                    查询
                </button>
            </div>

        </form>

        <hr />

        <!--数据列表-->
        <table class="table table-hover table-bordered">
            <thead class="bg-primary">
            <tr>
                <th>#</th>
                <th>客户名称</th>
                <th class="hidden-xs hidden-sm">概要</th>
                <th class="hidden-xs">联系人</th>
                <th class="hidden-xs">联系电话</th>
                <th class="hidden-xs hidden-sm">创建时间</th>
                <th>状态</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${pageInfo.list}" var="dev">
                <f:formatDate value="${dev.creationTime}" var="createDate" pattern="yyyy/MM/dd HH:mm:ss"/>
                <tr>
                    <td>${dev.id}</td>
                    <td>${dev.customerName}</td>
                    <td class="hidden-xs hidden-sm">${dev.title}</td>
                    <td class="hidden-xs">${dev.linkman}</td>
                    <td class="hidden-xs">${dev.tel}</td>
                    <td class="hidden-xs hidden-sm">${createDate}</td>
                    <td>
                        <c:if test="${dev.status==1}">
                            <div class="text-primary">
                                <span class="glyphicon glyphicon-signal" title="开发中"></span>
                                <span class="hidden-xs">开发中</span>
                            </div>
                        </c:if>
                        <c:if test="${dev.status==2}">
                            <div class="text-success">
                                <span class="glyphicon glyphicon-ok" title="成功"></span>
                                <span class="hidden-xs">成功</span>
                            </div>
                        </c:if>
                        <c:if test="${dev.status==3}">
                            <div class="text-danger">
                                <span class="glyphicon glyphicon-remove" title="失败"></span>
                                <span class="hidden-xs">失败</span>
                            </div>
                        </c:if>
                    </td>
                    <td>
                        <div class="btn-group btn-group-xs" data-id="${dev.id}">
                            <button class="btn btn-default" title="查看" data-toggle="modal" data-fond-dev="${dev.id}">
                                <span class="glyphicon glyphicon-zoom-in"></span>
                                <span class="hidden-xs">查看</span>
                            </button>
                            <c:if test="${dev.status==1}">
                            <button class="btn btn-default" title="制定计划" data-toggle="modal" data-plan-dev="${dev.id}">
                                <span class="glyphicon glyphicon-flag"></span>
                                <span class="hidden-xs">制定计划</span>
                            </button>
                            <button class="btn btn-default exec-complete" data-sale-dev="${dev.id}">
                                <span class="glyphicon glyphicon-record"></span>
                                <span class="hidden-xs">完成开发</span>
                            </button>
                            </c:if>
                        </div>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

        <!-- 数据分页部分-->
        <div class="text-center">
            <ul class="pagination">
                <li ${pageInfo.pageNum eq 1?'class="disabled"':''}>
                    <a href="/html/~sale/devs?page=${pageInfo.prePage}">&lt;</a>
                </li>
                <c:forEach items="${pageInfo.navigatepageNums}" var="i">
                    <li ${i eq pageInfo.pageNum?'class="active"':''}>
                        <a href="/html/~sale/devs?page=${i}">${i}</a>
                    </li>
                </c:forEach>
                <li ${pageInfo.pages eq pageInfo.pageNum?'class="disabled"':''}>
                    <a
                            <c:if test="${pageInfo.pages != pageInfo.pageNum}">
                                href="/html/~sale/devs?page=${pageInfo.nextPage}"
                            </c:if>
                    >&gt;</a>
                </li><!-- class="disabled" -->
            </ul>
        </div>
    </div>

    <!-- 查看销售机会开发信息部分-->
    <div class="modal fade in disabled" id="modal-show">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">

            </div>
        </div>
    </div>

    <!--制定客户开发计划部分-->
    <div class="modal fade in disabled" id="modal-plan">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">

            </div>
        </div>
    </div>
</body>
</html>
