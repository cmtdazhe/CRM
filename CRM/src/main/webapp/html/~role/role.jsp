<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${sessionScope.pageInfo==null}">
    <c:redirect url="/html/~role/roles"/>
</c:if>
<html>
<head>
    <title>客户关系管理系统-角色管理</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    <link rel="stylesheet" type="text/css" href="../../css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="../../css/bootstrap-theme.min.css" />
    <link rel="stylesheet" type="text/css" href="../../css/normalize.min.css" />

    <link rel="stylesheet" type="text/css" href="../../css/custom/scrollbar-style.min.css" />

    <script src="../../js/jquery-3.2.1.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../js/bootstrap.min.js" type="text/javascript" charset="utf-8"></script>

    <!--[if lte IE 8]>
    <script src="../../js/html5shiv.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../js/respond.min.js" type="text/javascript" charset="utf-8"></script>
    <![endif]-->

    <!-- 界面自定义CSS文件 -->
    <link rel="stylesheet" type="text/css" href="../../css/custom/scrollbar-style.min.css" />
    <link rel="stylesheet" type="text/css" href="../../css/custom/html-role-index.min.css" />

    <!--界面自定义JS文件-->
    <%--<script src="../../js/custom/tip-popover.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../js/custom/html-role-index.js" type="text/javascript" charset="utf-8"></script>--%>
    <script src="../../js/crmJs/role.js" type="text/javascript" charset="utf-8"></script>
</head>
<body>
    <div class="container-fluid">

        <!--当前页面地理位置 (面包屑导航)-->
        <ul class="breadcrumb">
            <li>权限&amp;角色管理</li>
            <li>角色管理</li>
        </ul>

        <!--搜索表单及工具按钮-->
        <form action="/html/~role/roles" id="form-search" method="post" class="form-inline">
            <input type="hidden" name="option_type" value="form">
            <div class="form-group">
                <label class="control-label">角色名称：</label>
                <input class="form-control" type="text" name="name" value="${sessionScope.role_name}"/>

                <label class="control-label">描述：</label>
                <input class="form-control" type="text" name="remark" value="${sessionScope.role_remark}"/>
            </div>
            <div class="form-group">
                <label class="control-label">标志：</label>
                <select class="form-control" name="statusOne">
                    <option value="-1">不限</option>
                    <option value="1" class="text-danger" ${sessionScope.role_status eq 1?'selected=selected':''}>禁用</option>
                    <option value="0" class="text-primary" ${sessionScope.role_status eq 0?'selected=selected':''}>启用</option>
                </select>
            </div>
            <div class="form-group btn-group">
                <button class="btn btn-default">
                    <span class="glyphicon glyphicon-search"></span>
                    查询
                </button>
                <button class="btn btn-default" type="button" data-toggle="modal" data-target="#modal-add">
                    <span class="glyphicon glyphicon-plus"></span>
                    新建
                </button>
            </div>

        </form>

        <hr />

        <!--数据表格部分-->
        <table class="table table-hover table-bordered">
            <thead class="bg-primary">
            <tr>
                <th class="hidden-xs">#</th>
                <th>角色名称</th>
                <th class="hidden-xs">描述</th>
                <th>标志</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
                <c:forEach var="role" items="${sessionScope.pageInfo.list}">
                    <c:if test="${role.id==-1}">
                        <tr class="bg-success text-primary">
                            <td class="hidden-xs">${role.id}</td>
                            <td>${role.name}</td>
                            <td class="hidden-xs">${role.remark}</td>
                            <td colspan="2"><i>&lt;不可操作&gt;</i></td>
                        </tr>
                    </c:if>
                    <c:if test="${role.id!=-1}">
                    <tr ${role.status==false?'class="text-muted" style="text-decoration: underline line-through;"':''}>
                        <td class="hidden-xs">${role.id}</td>
                        <td>${role.name}</td>
                        <td class="hidden-xs">${role.remark}</td>
                        <td>
                            <c:if test="${role.status==true}">
                                <span class="glyphicon glyphicon-ok text-success" title="启用"></span>
                                <span class="hidden-xs">启用</span>
                            </c:if>
                            <c:if test="${role.status==false}">
                                <span class="glyphicon glyphicon-remove text-danger" title="禁用"></span>
                                <span class="hidden-xs">禁用</span>
                            </c:if>
                        </td>
                        <td>
                            <div class="btn-group btn-group-xs">
                                <button class="btn btn-default" data-role-edit="${role.id}">
                                    <span class="glyphicon glyphicon-edit"></span>
                                    <span class="hidden-xs">编辑</span>
                                </button>

                                <c:if test="${role.status==true}">
                                <button  class="btn btn-warning" data-role-status="${role.id}">
                                    <span class="glyphicon glyphicon-ban-circle"></span>
                                    <span class="hidden-xs">禁用</span>
                                </button>
                                <button  class="btn btn-default" data-assign="${role.id}">
                                        <span class="glyphicon glyphicon-eye-open"></span>
                                        <span>权限</span>
                                </button>
                                </c:if>
                                <c:if test="${role.status==false}">
                                <button  class="btn btn-primary" data-role-status="${role.id}">
                                    <span class="glyphicon glyphicon-ok-circle"></span>
                                    <span class="hidden-xs">启用</span>
                                </button>
                                <button class="btn btn-default disabled" title="被禁用角色不能分配权限">
                                    <span class="glyphicon glyphicon-eye-close"></span>
                                    <span class="hidden-xs">权限</span>
                                </button>
                                </c:if>

                                <button class="btn btn-danger" data-del-id="${role.id}" >
                                    <span class="glyphicon glyphicon-remove"></span>
                                    <span class="hidden-xs">删除</span>
                                </button>
                            </div>
                        </td>
                    </tr>
                    </c:if>
                </c:forEach>
            </tbody>
        </table>


        <!-- TODO 分页部分 -->
        <div class="text-center">
            <ul class="pagination">
                <li ${sessionScope.pageInfo.pageNum le 1?'class="disabled"':''}>
                    <a href="/html/~role/roles?page=${sessionScope.pageInfo.prePage}">&lt;</a>
                </li>
                <c:forEach items="${sessionScope.pageInfo.navigatepageNums}" var="i">
                    <li ${i eq sessionScope.pageInfo.pageNum?'class="active"':''}>
                        <a href="/html/~role/roles?page=${i}">${i}</a>
                    </li>
                </c:forEach>
                <li ${sessionScope.pageInfo.pages gt sessionScope.pageInfo.pageNum?'class="disabled"':''}>
                    <a href="/html/~role/roles?page=${sessionScope.pageInfo.nextPage}">&gt;</a>
                </li><!-- class="disabled" -->
            </ul>
        </div>

    </div>

    <!-- TODO 添加角色modal部分-->
    <div class="modal fade" id="modal-add">
        <div class="modal-dialog">
            <div class="modal-content">

                <div class="modal-header">
                            <span class="h3">
                                <span class="glyphicon glyphicon-plus"></span> 新增角色
                            </span>
                </div>

                <div class="modal-body">
                    <form id="form-add" action="/html/~role/add" class="form-horizontal" method="post">
                        <div class="form-group">
                            <label class="col-xs-3 control-label">角色名称：</label>
                            <div class="col-xs-9">
                                <input class="form-control" required="required" autofocus="autofocus" name="name"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-3 control-label">描述：</label>
                            <div class="col-xs-9">
                                <textarea class="form-control" name="remark"></textarea>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-3 control-label">标志：</label>
                            <div class="col-xs-9">
                                <div class="form-control-static text-success">
                                    <span class="glyphicon glyphicon-ok"></span> 启用
                                </div>
                            </div>
                        </div>

                    </form>
                </div>

                <div class="modal-footer">
                    <button class="btn btn-default" data-dismiss="modal">
                        <span class="glyphicon glyphicon-remove"></span>
                        关闭
                    </button>
                    <button class="btn btn-primary" form="form-add">
                        <span class="glyphicon glyphicon-save"></span>
                        新增
                    </button>
                </div>

            </div>
        </div>
    </div>

    <!-- TODO 修改角色modal部分-->
    <div class="modal fade" id="modal-edit">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                            <span class="h3">
                                <span class="glyphicon glyphicon-edit"></span> 编辑角色信息
                            <small>业务经理</small>
                            </span>
                </div>
                <div class="modal-body">
                    <form id="form-edit" action="/html/~role/edit" method="post" class="form-horizontal">
                        <input type="hidden" name="id">
                        <div class="form-group">
                            <label class="col-xs-3 control-label">角色编号：</label>
                            <div class="col-xs-9 form-control-static" id="role_id"></div>
                        </div>
                        <div class="form-group">
                            <label class="col-xs-3 control-label">名称：</label>
                            <div class="col-xs-9">
                                <input class="form-control" required="required" name="name"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-xs-3 control-label">描述：</label>
                            <div class="col-xs-9">
                                <textarea class="form-control" name="remark"></textarea>
                            </div>
                        </div>
                        <div class="form-group" id="status_div">

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
            </div>
        </div>
    </div>

    <!-- TODO 仅限分配modal部分 -->
    <div class="modal fade" id="modal-assign-power">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">

            </div>
        </div>
    </div>
</body>
</html>
