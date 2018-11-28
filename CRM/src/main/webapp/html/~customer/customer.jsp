<%@ page language="java" pageEncoding="utf-8" contentType="text/html;charset=UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${pageInfo4==null}">
    <c:redirect url="/html/~customer/customers"/>
</c:if>
<html>
<head>
    <title>客户关系管理系统-客户信息管理</title>
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
    <link rel="stylesheet" type="text/css" href="../../css/custom/html-cust-index.min.css" />

    <!--界面自定义JS文件-->
    <script src="../../js/custom/tip-popover.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../js/crmJs/customer.js" type="text/javascript" charset="utf-8"></script>
 <%--   <script src="../../js/custom/html-cust-index.js" type="text/javascript" charset="utf-8"></script>--%>

</head>

<body>
<div class="container-fluid">

    <!--TODO 当前页面地理位置 (面包屑导航)-->
    <ul class="breadcrumb">
        <li>客户管理</li>
        <li>客户信息管理</li>
    </ul>

    <!--TODO 搜索表单及工具按钮-->
    <form id="form-search" method="post" action="/html/~customer/customers" class="form-inline">
        <input type="hidden" name="option_type" value="form">
        <div class="form-group">
            <label class="control-label">客户编号：</label>
            <div class="input-group">
                <span class="input-group-addon">CST</span>
                <input class="form-control" type="text" name="id" value="${customers_id}"/>
            </div>

            <label class="control-label">名称：</label>
            <input class="form-control" type="text" name="name" value="${customers_name}"/>

            <label class="control-label">地区：</label>

            <select class="form-control" name="region">
                <option value="">全部</option>
                <option value="北京" <c:if test="${customers_region=='北京'}">selected="selected"</c:if> >北京</option>
                <option value="华北地区" <c:if test="${customers_region=='华北地区'}">selected="selected"</c:if>>华北</option>
                <option value="华东地区" <c:if test="${customers_region=='华东地区'}">selected="selected"</c:if>>华东</option>
                <option value="华中地区" <c:if test="${customers_region=='华中地区'}">selected="selected"</c:if>>华中</option>
                <option value="华南地区" <c:if test="${customers_region=='华南地区'}">selected="selected"</c:if>>华南</option>
                <option value="西部地区" <c:if test="${customers_region=='西部地区'}">selected="selected"</c:if>>西部</option>
            </select>

        </div>

        <div class="form-group">
            <label class="control-label">客户经理：</label>
            <input class="form-control" type="text" name="userName" value="${customers_userName}"/>

            <label class="control-label">客户等级：</label>
            <select class="form-control" name="level">
                <option value="">全部</option>
                <option value="战略合作伙伴" <c:if test="${customers_level=='战略合作伙伴'}">selected="selected"</c:if>>战略合作伙伴</option>
                <option value="大客户" <c:if test="${customers_level=='大客户'}">selected="selected"</c:if>>大客户</option>
                <option value="重点开发客户" <c:if test="${customers_level=='重点开发客户'}">selected="selected"</c:if>>重点开发客户</option>
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
            <th>#</th>
            <th>客户名称</th>
            <th class="hidden-xs hidden-sm">地区</th>
            <th class="hidden-xs">客户经理</th>
            <th class="hidden-xs">等级</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${pageInfo4.list}" var="cust">
        <tr>
            <td>${cust.id}</td>
            <td>${cust.name} </td>
            <td class="hidden-xs hidden-sm">${cust.region}</td>
            <td class="hidden-xs">${cust.user.name}</td>
            <td class="hidden-xs">${cust.level}</td>
            <td>
                <c:if test="${cust.status==0}">
                <div class="btn-group btn-group-xs" data-id="CST071201005">
                    <button class="btn btn-default" title="查看" data-toggle="modal" data-customer-show="${cust.id}">
                        <span class="glyphicon glyphicon-search"></span>
                        <span class="hidden-xs">查看</span>
                    </button>
                    <button class="btn btn-default" title="编辑" data-toggle="modal" data-customer-edit="${cust.id}">
                        <span class="glyphicon glyphicon-edit"></span>
                        <span class="hidden-xs">编辑</span>
                    </button>
                    <button class="btn btn-default" title="联系人" data-toggle="modal" data-customer-linkman="${cust.id}">
                        <span class="glyphicon glyphicon-user"></span>
                        <span class="hidden-xs">联系人</span>
                    </button>
                    <button class="btn btn-default" title="交往记录" data-toggle="modal" data-customer-assciation="${cust.id}">
                        <span class="glyphicon glyphicon-envelope"></span>
                        <span class="hidden-xs">交往记录</span>
                    </button>
                    <button class="btn btn-default" title="历史订单" data-toggle="modal" data-customer-order="${cust.id}">
                        <span class="glyphicon glyphicon-duplicate"></span>
                        <span class="hidden-xs">历史订单</span>
                    </button>
                    <button class="btn btn-default lost-cust" data-edit-status="${cust.id}">
                        <div class="text-danger">
                            <span class="glyphicon glyphicon-remove"></span>
                            <span class="hidden-xs">流失</span>
                        </div>
                    </button>
                </div>
                </c:if>
                <c:if test="${cust.status==2}">
                    <div class="btn-group btn-group-xs" data-id="CST071201005">
                        <button class="btn btn-default" title="查看" data-toggle="modal" data-customer-show="${cust.id}">
                            <span class="glyphicon glyphicon-search"></span>
                            <span class="hidden-xs">查看</span>
                        </button>
                        <button class="btn btn-default" title="编辑" data-toggle="modal" data-customer-edit="${cust.id}">
                            <span class="glyphicon glyphicon-edit"></span>
                            <span class="hidden-xs">编辑</span>
                        </button>
                        <button class="btn btn-default" title="联系人" data-toggle="modal" data-customer-linkman="${cust.id}">
                            <span class="glyphicon glyphicon-user"></span>
                            <span class="hidden-xs">联系人</span>
                        </button>
                        <button class="btn btn-default" title="交往记录" data-toggle="modal" data-customer-assciation="${cust.id}">
                            <span class="glyphicon glyphicon-envelope"></span>
                            <span class="hidden-xs">交往记录</span>
                        </button>
                        <!--功能未写-->
                        <button class="btn btn-default" title="历史订单" data-toggle="modal">
                            <span class="glyphicon glyphicon-duplicate"></span>
                            <span class="hidden-xs">历史订单</span>
                        </button>
                    </div>
                </c:if>
            </td>
        </tr>
        </c:forEach>
        </tbody>
    </table>

    <!--TODO 数据分页部分-->
    <div class="text-center">
        <ul class="pagination">
            <li ${pageInfo4.pageNum eq 1?'class="disabled"':''}>
                <a href="/html/~customer/customers?page=${pageInfo4.prePage}">&lt;</a>
            </li>
            <c:forEach items="${pageInfo4.navigatepageNums}" var="i">
            <li ${i eq pageInfo4.pageNum? 'class="active"':''}>
                <a href="/html/~customer/customers?page=${i}">${i}</a>
            </li>
            </c:forEach>
            <li ${pageInfo4.pages eq pageInfo4.pageNum?'class="disabled"':''}>
                <a
                        <c:if test="${pageInfo4.pages !=pageInfo4.pageNum}">
                        href="/html/~customer/customers?page=${pageInfo4.nextPage}"
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

<!--TODO 编辑客户信息modal部分-->
<div class="modal fade" id="modal-edit">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">

        </div>
    </div>
</div>

<!-- TODO 客户联系人modal部分 -->
<div class="modal fade" id="modal-linkman">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">

        </div>
    </div>
</div>

<!-- TODO 新增客户联系人信息modal部分 -->
<div class="modal fade" id="modal-add-linkman">
    <div class="modal-dialog">
        <form class="modal-content" id="form-add-linkman" method="post">
            <input type="hidden" name="customerId" value="${Linkcustomer.id}" id="customerId">
            <div class="modal-header">
                <button class="close" data-dismiss="modal">
                    <span class="glyphicon glyphicon-remove"></span>
                </button>
                <h3 class="modal-title">
                    新增客户联系人信息
                    <div class="visible-xs"></div>
                    <small id="names">${Linkcustomer.name}</small>
                </h3>
            </div>
            <div class="modal-body container-fluid">
                <div class="row">
                    <div class="form-horizontal">
                        <div class="form-group form-group-sm col-md-6">
                            <label class="col-xs-2 col-md-4 control-label">姓名</label>
                            <div class="col-xs-10 col-md-8">
                                <input class="form-control" required="required" autofocus="autofocus" name="name" id="name"/>
                            </div>
                        </div>

                        <div class="form-group form-group-sm col-md-6">
                            <label class="col-xs-2 col-md-4 control-label">性别</label>
                            <div class="col-xs-10 col-md-8">
                                <div class="form-control-static radio">
                                    <label><input type="radio" name="sex" checked="checked" value="男"/>男</label>
                                    <label><input type="radio" name="sex" value="女"/>女</label>
                                </div>
                            </div>
                        </div>

                        <div class="form-group form-group-sm col-md-6">
                            <label class="col-xs-2 col-md-4 control-label">职位</label>
                            <div class="col-xs-10 col-md-8">
                                <input class="form-control" required="required" name="job" id="job"/>
                            </div>
                        </div>

                        <div class="form-group form-group-sm col-md-6">
                            <label class="col-xs-2 col-md-4 control-label">办公电话</label>
                            <div class="col-xs-10 col-md-8">
                                <input class="form-control" type="tel" name="tel" id="tel"/>
                            </div>
                        </div>

                        <div class="form-group form-group-sm col-md-6">
                            <label class="col-xs-2 col-md-4 control-label">备注</label>
                            <div class="col-xs-10 col-md-8">
                                <textarea class="form-control" name="remark" id="remark"></textarea>
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
                <button class="btn btn-primary" type="button" id="btnSubmit">
                    <span class="glyphicon glyphicon-save"></span>
                    保存
                </button>
            </div>
        </form>
    </div>
</div>

<!-- TODO 编辑客户联系人信息modal部分 -->
<div class="modal fade" id="modal-edit-linkman">
    <div class="modal-dialog">
        <form class="modal-content" id="form-edit-linkman" method="post">
            <input type="hidden" name="id">
            <div class="modal-header">
                <button class="close" data-dismiss="modal">
                    <span class="glyphicon glyphicon-remove"></span>
                </button>
                <h3 class="modal-title">
                    编辑客户联系人信息
                    <div class="visible-xs"></div>
                    <small>${customer.name}</small>
                    <div class="visible-xs"></div>
                    <small>-${li.name}</small>
                </h3>
            </div>
            <div class="modal-body container-fluid">
                <div class="row">
                    <div class="form-horizontal">
                        <div class="form-group form-group-sm col-md-6">
                            <label class="col-xs-2 col-md-4 control-label">姓名</label>
                            <div class="col-xs-10 col-md-8">
                                <input class="form-control" name="name" required="required" autofocus="autofocus" />
                            </div>
                        </div>

                        <div class="form-group form-group-sm col-md-6">
                            <label class="col-xs-2 col-md-4 control-label">性别</label>
                            <div class="col-xs-10 col-md-8">
                                <div class="form-control-static radio">
                                    <label><input type="radio" name="sex" value="男" checked="checked"/>男</label>
                                    <label><input type="radio" name="sex" value="女"/>女</label>
                                </div>
                            </div>
                        </div>

                        <div class="form-group form-group-sm col-md-6">
                            <label class="col-xs-2 col-md-4 control-label">职位</label>
                            <div class="col-xs-10 col-md-8">
                                <input class="form-control" name="job" required="required" />
                            </div>
                        </div>

                        <div class="form-group form-group-sm col-md-6">
                            <label class="col-xs-2 col-md-4 control-label">办公电话</label>
                            <div class="col-xs-10 col-md-8">
                                <input class="form-control" name="tel" type="tel" />
                            </div>
                        </div>

                        <div class="form-group form-group-sm col-md-6">
                            <label class="col-xs-2 col-md-4 control-label">备注</label>
                            <div class="col-xs-10 col-md-8">
                                <textarea class="form-control" name="remark"></textarea>
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
                <button class="btn btn-primary" type="submit">
                    <span class="glyphicon glyphicon-edit"></span>
                    更新
                </button>
            </div>
        </form>
    </div>
</div>

<!-- TODO 客户联交往记录modal部分 -->
<div class="modal fade" id="modal-activites">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">

        </div>
    </div>
</div>

<!-- TODO 新增客户交往记录modal部分 -->
<div class="modal fade" id="modal-add-activity">
    <div class="modal-dialog">
        <form class="modal-content" id="form-add-activity">
            <input type="hidden" name="customerId" id="customerIds">
            <div class="modal-header">
                <button class="close" data-dismiss="modal">
                    <span class="glyphicon glyphicon-remove"></span>
                </button>
                <h3 class="modal-title">
                    新增客户交往记录
                    <div class="visible-xs"></div>
                    <small id="customerName">${customer.name}</small>
                </h3>
            </div>
            <div class="modal-body">
                <div class="form-horizontal">
                    <div class="form-group form-group-sm">
                        <label class="col-xs-1 col-md-2 control-label">时间</label>
                        <div class="col-xs-5 col-md-4">
                            <input class="form-control" type="date" required="required" name="creationTime" autofocus="autofocus" />
                        </div>
                    </div>

                    <div class="form-group form-group-sm">
                        <label class="col-xs-2 control-label">主题</label>
                        <div class="col-xs-10">
                            <input class="form-control" name="title" required="required" />
                        </div>
                    </div>

                    <div class="form-group form-group-sm">
                        <label class="col-xs-2 control-label">地点</label>
                        <div class="col-xs-10">
                            <input class="form-control" name="place" />
                        </div>
                    </div>

                    <div class="form-group form-group-sm">
                        <label class="col-xs-2 control-label">详细信息</label>
                        <div class="col-xs-10">
                            <textarea class="form-control" name="remark"></textarea>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-default" type="button" data-dismiss="modal">
                    <span class="glyphicon glyphicon-remove"></span>
                    关闭
                </button>
                <button class="btn btn-primary" type="button" id="activitySubimt">
                    <span class="glyphicon glyphicon-save"></span>
                    保存
                </button>
            </div>
        </form>
    </div>
</div>


</body>

</html>