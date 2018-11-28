<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:if test="${pageInfo3 == null}">
    <c:redirect url="/html/~sale/sales"/>
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


    <script src="../../js/html5shiv.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../js/respond.min.js" type="text/javascript" charset="utf-8"></script>


    <!-- 界面自定义CSS文件 -->
    <link rel="stylesheet" type="text/css" href="../../css/custom/scrollbar-style.min.css" />
    <link rel="stylesheet" type="text/css" href="../../css/custom/html-sale-index.min.css" />

    <script src="../../js/crmJs/sale.js" type="text/javascript" charset="utf-8"></script>

    <script>
        document.getElementById("title").value="${salesOpportunity.title}"
        document.getElementById("remark").value="${salesOpportunity.remark}"
    </script>
</head>
<body>
    <div class="container-fluid">
        <!-- 当前页面地理位置 (面包屑导航)-->
        <ul class="breadcrumb">
            <li>营销管理</li>
            <li>销售机会管理</li>
        </ul>

        <!--搜索表单及工具按钮-->
        <form id="form-search" method="post" action="/html/~sale/sales" class="form-inline">
            <input type="hidden" name="option_type" value="form">
            <div class="form-group">
                <label class="control-label">客户名称：</label>
                <input class="form-control" type="text" name="customerName" value="${SalesOpportunity_customerName}"/>

                <label class="control-label">概要：</label>
                <input class="form-control" type="text" name="title" value="${SalesOpportunity_title}"/>

                <label class="control-label">联系人：</label>
                <input class="form-control" type="text" name="linkman" value="${SalesOpportunity_linkman}"/>
            </div>

            <div class="form-group btn-group">
                <button class="btn btn-default">
                    <span class="glyphicon glyphicon-search"></span>
                    查询
                </button>
                <button class="btn btn-default" type="button" data-toggle="modal" data-target="#modal-add" data-backdrop="false">
                    <span class="glyphicon glyphicon-plus"></span>
                    新建
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
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${pageInfo3.list}" var="sale">
            <f:formatDate value="${sale.creationTime}" var="createDate" pattern="yyyy/MM/dd"/>
            <tr>
                <td>${sale.id}</td>
                <td>${sale.customerName}</td>
                <td class="hidden-xs hidden-sm">${sale.title}</td>
                <td class="hidden-xs">${sale.linkman}</td>
                <td class="hidden-xs">${sale.tel}</td>
                <td class="hidden-xs hidden-sm">${createDate}</td>
                <td>
                    <div class="btn-group btn-group-xs" data-id="1">
                        <button data-assign-sale="${sale.id}" class="btn btn-default" title="指派">
                            <span class="glyphicon glyphicon-hand-right"></span>
                            <span class="hidden-xs">指派</span>
                        </button>
                        <button class="btn btn-default" data-edit-sale="${sale.id}">
                            <span class="glyphicon glyphicon-edit"></span>
                            <span class="hidden-xs">编辑</span>
                        </button>
                        <button data-del-sale="${sale.id}" class="btn btn-default">
                            <div class="text-danger">
                                <span class="glyphicon glyphicon-remove"></span>
                                <span class="hidden-xs">删除</span>
                            </div>
                        </button>
                    </div>
                </td>
            </tr>
            </c:forEach>
            </tbody>
        </table>

        <!-- 数据分页部分-->
        <div class="text-center">
            <ul class="pagination">
                <li ${pageInfo3.pageNum eq 1?'class="disabled"':''}>
                    <a href="/html/~sale/sales?page=${pageInfo3.prePage}">&lt;</a>
                </li>
                <c:forEach items="${pageInfo3.navigatepageNums}" var="i">
                    <li ${i eq pageInfo3.pageNum?'class="active"':''}>
                        <a href="/html/~sale/sales?page=${i}">${i}</a>
                    </li>
                </c:forEach>
                <li ${pageInfo3.pages eq pageInfo3.pageNum?'class="disabled"':''}>
                    <a
                            <c:if test="${pageInfo3.pages != pageInfo3.pageNum}">
                                href="/html/~sale/sales?page=${pageInfo3.nextPage}"
                            </c:if>
                    >&gt;</a>
                </li><!-- class="disabled" -->
            </ul>
        </div>
    </div>

    <!-- 添加销售机会modal部分-->
    <div class="modal fade" data-backdrop="false" id="modal-add">
        <div class="modal-dialog modal-lg">
            <form action="/html/~sale/add-sale" id="form-add" class="modal-content" method="post">
                <div class="modal-header">
                    <button class="close" data-dismiss="modal">
                        <span class="glyphicon glyphicon-remove"></span>
                    </button>
                    <h3 class="modal-title">新建销售机会</h3>
                </div>
                <div class="modal-body">
                    <div class="container-fluid">
                        <div class="row form-horizontal">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="col-xs-4 control-label">客户名称</label>
                                    <div class="col-xs-8">
                                        <input class="form-control" type="text" required="required" autofocus="autofocus" name="customerName"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-xs-4 control-label">联系人</label>
                                    <div class="col-xs-8">
                                        <input class="form-control" type="text" name="linkman" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-xs-4 control-label">联系电话</label>
                                    <div class="col-xs-8">
                                        <input class="form-control" type="tel" name="tel"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-xs-4 control-label">概要</label>
                                    <div class="col-xs-8">
                                        <textarea class="form-control" name="title" style="min-height: 50px;"></textarea>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="col-xs-4 control-label">机会来源</label>
                                    <div class="col-xs-8">
                                        <input class="form-control" name="source" type="text" />
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-xs-4 control-label">
                                        成功概率
                                        <span class="text-muted" id="range_ds_1">(0%)</span>
                                    </label>
                                    <div class="col-xs-8">
                                        <input class="form-control-static" name="rate" type="range" max="100" min="0" value="0"
                                               data-target="#range_ds_1" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-xs-4 control-label">描述</label>
                                    <div class="col-xs-8">
                                        <textarea class="form-control" name="remark"  style="min-height: 100px;"></textarea>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-default" type="button" data-dismiss="modal">
                        <span class="glyphicon glyphicon-remove"></span>
                        关闭
                    </button>
                    <button class="btn btn-primary" form="form-add">
                        <span class="glyphicon glyphicon-save"></span>
                        确定
                    </button>
                </div>
            </form>
        </div>
    </div>


    <!-- 修改销售机会modal部分-->
    <div class="modal fade" id="modal-edit">
        <div class="modal-dialog">
            <div class="modal-content">

            </div>
        </div>
    </div>
</body>
</html>
