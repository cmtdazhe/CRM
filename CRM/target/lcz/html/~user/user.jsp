<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${sessionScope.pageInfos == null}">
	<c:redirect url="/html/~user/users"/>
</c:if>
<html>
<head>
    <title>客户关系管理系统-用户信息管理</title>
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


    <!-- 界面自定义CSS文件 -->
    <link rel="stylesheet" type="text/css" href="../../css/custom/scrollbar-style.min.css" />

    <!--界面自定义JS文件-->

    <script src="../../js/crmJs/user.js" type="text/javascript" charset="utf-8"></script>
</head>

<body>
<div class="container-fluid">

    <!--当前页面地理位置 (面包屑导航)-->
    <ul class="breadcrumb">
        <li>用户管理</li>
        <li>用户信息管理</li>
    </ul>

    <!--搜索表单及工具按钮-->
			<form id="form-search" class="form-inline" action="/html/~user/users" method="post">
				<input type="hidden" name="option_type" value="form">
				<div class="form-group">
					<label class="control-label">用户名称：</label>
					<input class="form-control" type="text" name="name" value="${sessionScope.user_name}"/>
					<label class="control-label">标志：</label>
					<select class="form-control" name="statusOne">
						<option value="-1">不限</option>
						<option value="1" class="text-danger" ${sessionScope.user_stauts eq 1?'selected=selected':''}>禁用</option>
						<option value="0" class="text-primary" ${sessionScope.user_stauts eq 0?'selected=selected':''}>启用</option>
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
    <table class="table table-hover table-bordered data-table">
        <thead class="bg-primary">
        <tr>
            <th class="hidden-xs">#</th>
            <th>登录名</th>
            <th>姓名</th>
            <th>标志</th>
            <th>角色</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${sessionScope.pageInfos.list}" var="user">
            <tr>
                <td class="hidden-xs">${user.id}</td>
                <td>${user.login}</td>
                <td>${user.name}</td>
                <td>
                    <c:if test="${user.status==true}">
                        <div class="text-success" title="启用">
                            <span class="glyphicon glyphicon-ok"></span> 启用
                        </div>
                    </c:if>
                    <c:if test="${user.status==false}">
                        <div class="text-danger" title="禁用">
                            <span class="glyphicon glyphicon-remove"></span> 禁用
                        </div>
                    </c:if>
                </td>
                <td>${user.role.name}</td>
                <td>
                    <div class="btn-group btn-group-xs">
                        <button class="btn btn-default" data-user-edit="${user.id}">
                            <span class="glyphicon glyphicon-edit"></span>
                            <span class="hidden-xs">编辑</span>
                        </button>
                        <c:if test="${user.status==true}">
                            <button class="btn btn-warning" data-user-status="${user.id}">
                                <span class="glyphicon glyphicon-ban-circle"></span>
                                <span class="hidden-xs">禁用</span>
                            </button>
                        </c:if>
                        <c:if test="${user.status==false}">
                            <button class="btn btn-success" data-user-status="${user.id}">
                                <span class="glyphicon glyphicon-ok-circle"></span>
                                <span class="hidden-xs">启用</span>
                            </button>
                        </c:if>
                        <c:if test="${user.role.name!='超级管理员'}">
                            <button class="btn btn-default" data-user-del="${user.id}">
                                <div class="text-danger">
                                    <span class="glyphicon glyphicon-remove"></span>
                                    <span class="hidden-xs">删除</span>
                                </div>
                            </button>
                        </c:if>
                    </div>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

			<!-- TODO 分页部分 -->
			<div class="text-center">
				<ul class="pagination">
					<li ${sessionScope.pageInfos.pageNum le 1?'class="disabled"':''}>
						<a href="/html/~user/users?page=${sessionScope.pageInfos.prePage}">&lt;</a>
					</li>
					<c:forEach items="${sessionScope.pageInfos.navigatepageNums}" var="i">
						<li ${i eq sessionScope.pageInfos.pageNum?'class="active"':''}>
							<a href="/html/~user/users?page=${i}">${i}</a>
						</li>
					</c:forEach>
					<li ${sessionScope.pageInfos.pages gt sessionScope.pageInfos.pageNum?'class="disabled"':''}>
						<a href="/html/~user/users?page=${sessionScope.pageInfos.nextPage}">&gt;</a>
					</li><!-- class="disabled" -->
				</ul>
			</div>


<!-- TODO 添加用户modal部分-->
<div class="modal fade" id="modal-add">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
					<span class="h3">
						<span class="glyphicon glyphicon-plus"></span> 新增用户
					</span>
			</div>
			<div class="modal-body">
				<form id="form-add" action="/html/~user/add" class="form-horizontal" method="post">
					<div class="form-group">
						<label class="col-xs-3 control-label">登录名：</label>
						<div class="col-xs-9">
							<input class="form-control" type="email" name="login" required="required" placeholder="请输入邮件地址" />
						</div>
					</div>
					<div class="form-group">
						<label class="col-xs-3 control-label">姓名：</label>
						<div class="col-xs-9">
							<input class="form-control" name="name"/>
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
					<div class="form-group">
						<label class="col-xs-3 control-label">角色：</label>
						<div class="col-xs-9">
							<select class="form-control" name="roleId">
								<option value="">暂不指定</option>
								<c:forEach items="${sessionScope.roles}" var="role">
									<option value="${role.id}">${role.name}</option>
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

		</div>
	</div>
</div>

<!-- TODO 仅限分配modal部分 -->
<div class="modal fade" id="modal-power">
	<div class="modal-dialog modal-lg">
		<form action="" class="modal-content" id="form-power">
			<div class="modal-header">
				<div class="modal-title h3">
					<span class="glyphicon glyphicon-eye-close"></span> 分配权限
					<small>业务经理</small>
				</div>
			</div>
			<div class="modal-body">
				<div class="panel-group">

					<div class="panel panel-info">
						<div class="panel-heading">
							<a class="close" data-toggle="collapse" data-target="#panel-1">
								<span class="caret"></span>
							</a>
							<div class="panel-title">
								<label class="checkbox-inline">
									<input type="checkbox" checked="checked" />
									营销
								</label>
								<span class="badge">2</span>
							</div>
						</div>
						<div id="panel-1" class="collapse in">
							<div class="panel-body">
								<div class="row">
									<div class="col-xs-6 col-sm-4 col-md-3 col-lg-2">
										<label class="checkbox-inline">
											<input type="checkbox" checked="checked" />销售机会管理
										</label>
									</div>
									<div class="col-xs-6 col-sm-4 col-md-3 col-lg-2">
										<label class="checkbox-inline disabled" title="该权限已被禁用">
											<input type="checkbox" checked="checked" disabled="disabled" />客户开发管理
										</label>
									</div>
								</div>
							</div>
						</div>
					</div>

					<div class="panel panel-info">
						<div class="panel-heading">
							<a class="close" data-toggle="collapse" data-target="#panel-2">
								<span class="caret"></span>
							</a>
							<div class="panel-title">
								<label class="checkbox-inline">
									<input type="checkbox" />
									客户
								</label>
								<span class="badge">2</span>
							</div>
						</div>
						<div id="panel-2" class="collapse in">
							<div class="panel-body">
								<div class="row">
									<div class="col-xs-6 col-sm-4 col-md-3 col-lg-2">
										<label class="checkbox-inline">
											<input type="checkbox" />客户信息管理
										</label>
									</div>
									<div class="col-xs-6 col-sm-4 col-md-3 col-lg-2">
										<label class="checkbox-inline">
											<input type="checkbox" />	客户流失管理
										</label>
									</div>
								</div>
							</div>
						</div>
					</div>

					<div class="panel panel-info">
						<div class="panel-heading">
							<a class="close" data-toggle="collapse" data-target="#panel-3">
								<span class="caret"></span>
							</a>
							<div class="panel-title">
								<label class="checkbox-inline">
									<input type="checkbox" />
									权限&amp;角色
								</label>
								<span class="badge">2</span>
							</div>
						</div>
						<div id="panel-3" class="collapse in">
							<div class="panel-body">
								<div class="row">
									<div class="col-xs-6 col-sm-4 col-md-3 col-lg-2">
										<label class="checkbox-inline">
											<input type="checkbox"  />权限管理
										</label>
									</div>
									<div class="col-xs-6 col-sm-4 col-md-3 col-lg-2">
										<label class="checkbox-inline">
											<input type="checkbox" />角色管理
										</label>
									</div>
								</div>
							</div>
						</div>
					</div>

					<div class="panel panel-warning">
						<div class="panel-heading">
							<a class="close" data-toggle="collapse" data-target="#panel-4">
								<span class="caret"></span>
							</a>
							<div class="panel-title">
								<label class="checkbox-inline">
									<input type="checkbox" />
									未分组
								</label>
								<span class="badge">2</span>
							</div>
						</div>
						<div id="panel-4" class="collapse in">
							<div class="panel-body">
								<div class="row">
									<div class="col-xs-6 col-sm-4 col-md-3 col-lg-2">
										<label class="checkbox-inline">
											<input type="checkbox" />用户信息管理
										</label>
									</div>
									<div class="col-xs-6 col-sm-4 col-md-3 col-lg-2">
										<label class="checkbox-inline">
											<input type="checkbox" />用户角色分配
										</label>
									</div>
								</div>
							</div>
						</div>
					</div>

				</div>
			</div>
			<div class="modal-footer">
				<button class="btn btn-default" data-dismiss="modal">
					<span class="glyphicon glyphicon-remove"></span>
					关闭
				</button>
				<button class="btn btn-primary">
					<span class="glyphicon glyphicon-save"></span>
					保存
				</button>
			</div>
		</form>
	</div>
</div>
</div>
</body>
</html>