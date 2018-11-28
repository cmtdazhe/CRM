<%@page language="java" contentType="text/html; charset=utf-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${sessionScope.pageInfo1==null}">
	<c:redirect url="/html/~power/powers"/>
</c:if>
<html>
<head>
	<base href="../" />
	<title>客户关系管理系统-权限管理</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
	<link rel="stylesheet" type="text/css" href="../css/bootstrap.min.css" />
	<link rel="stylesheet" type="text/css" href="../css/bootstrap-theme.min.css" />
	<link rel="stylesheet" type="text/css" href="../css/normalize.min.css" />

	<link rel="stylesheet" type="text/css" href="../css/custom/scrollbar-style.min.css" />
	<script src="../js/jquery-3.2.1.min.js" type="text/javascript" charset="utf-8"></script>
	<script src="../js/bootstrap.min.js" type="text/javascript" charset="utf-8"></script>

	<!--[if lte IE 8]>
	<!--<script src="../js/html5shiv.min.js" type="text/javascript" charset="utf-8"></script>
	<script src="../js/respond.min.js" type="text/javascript" charset="utf-8"></script>-->


	<!-- 界面自定义CSS文件 -->
	<link rel="stylesheet" type="text/css" href="../css/custom/scrollbar-style.min.css" />

	<!--界面自定义JS文件-->
	<script src="../js/crmJs/power.js" type="text/javascript" charset="utf-8"></script>
	<style>
		.btnss{
			position: absolute;
			left: 948px;
			top:57px;
		}
	</style>
</head>
	<body>
		<div class="container-fluid">
			<!--当前页面地理位置 (面包屑导航)-->
			<ul class="breadcrumb">
				<li>权限&amp;角色管理</li>
				<li>权限管理</li>
			</ul>

			<!--搜索表单及工具按钮-->
			<form id="form-search" action="/html/~power/powers" method="post" class="form-inline">
				<input type="hidden" name="option_type" value="form">
				<div class="form-group">
					<label class="control-label">权限文本：</label>
					<input class="form-control" type="text" name="title" value="${sessionScope.power_title}"/>
					<label class="control-label">类别：</label>
					<select class="form-control" name="typeId">
						<option value="-1">全部</option>
						<option value="0">未设置</option>
						<c:forEach items="${powerTypes}" var="p">
								<option value="${p.id}" ${p.id eq sessionScope.power_typeId?'selected=selected':''}>${p.name}</option>
						</c:forEach>
					</select>
					<label class="control-label">描述：</label>
					<input class="form-control" type="text" name="remark" value="${sessionScope.power_remark}"/>
				</div>
				<div class="form-group">
					<label class="control-label">标志：</label>
					<select class="form-control" name="statusOne">
						<option value="-1">不限</option>
						<option value="1" class="text-danger" ${1 eq sessionScope.power_status?'selected=selected':''}>禁用</option>
						<option value="0" class="text-primary" ${0 eq sessionScope.power_status?'selected=selected':''}>启用</option>
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
				<div class="btnss">
					<button data-power-type="" class="btn btn-primary">
						<span class="glyphicon glyphicon-list"></span>
						<span>权限类别管理</span>
					</button>
				</div>
			<hr />

			<!--数据表格部分-->
			<table class="table table-hover table-bordered power-table">
				<thead class="bg-primary">
					<tr>
						<th class="hidden-xs">#</th>
						<th>权限文本</th>
						<th>类别</th>
						<th>URL</th>
						<th class="hidden-xs">描述</th>
						<th>标志</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${pageInfo1.list}" var="p">
					<tr>
						<td class="hidden-xs">${p.id}</td>
						<td>${p.title}</td>
						<td>
							<c:forEach items="${powerTypes}" var="pt">
								<c:if test="${p.typeId eq pt.id}">${pt.name}</c:if>
							</c:forEach>
						</td>
						<td>
							<a href="/html/${p.url}">${p.url}</a>
						</td>
						<td class="hidden-xs">${p.remark}</td>
						<td>
							<div>
								<c:if test="${p.status==true}">
									<span class="glyphicon glyphicon-ok text-success" title="启用"></span>
									<span class="hidden-xs">启用</span>
								</c:if>
								<c:if test="${p.status==false}">
									<span class="glyphicon glyphicon-remove text-danger" title="禁用"></span>
									<span class="hidden-xs">禁用</span>
								</c:if>
							</div>
						</td>
						<td>
							<div class="btn-group btn-group-xs">
								<button class="btn btn-default" data-power-edit="${p.id}">
									<span class="glyphicon glyphicon-edit"></span>
									<span class="hidden-xs">编辑</span>
								</button>
								<c:if test="${p.status=true}">
									<button class="btn btn-warning"  data-edit-status="${p.id}">
										<span class="glyphicon glyphicon-ban-circle"></span>
										<span class="hidden-xs">禁用</span>
									</button>
								</c:if>
								<c:if test="${p.status=false}">
									<button class="btn btn-primary"  data-edit-status="${p.id}">
										<span class="glyphicon glyphicon-ok-circle"></span>
										<span class="hidden-xs">启用</span>
									</button>
								</c:if>
								<button class="btn btn-danger" title="删除" data-del-id="${p.id	}">
									<span class="glyphicon glyphicon-remove"></span>
									<span class="hidden-xs">删除</span>
								</button>
							</div>
						</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>

			<!-- TODO 分页部分 -->
			<div class="text-center">
				<ul class="pagination">
					<li ${sessionScope.pageInfo1.pageNum eq 1?'class="disabled"':''}>
						<a href="/html/~power/powers?page=${sessionScope.pageInfo1.prePage}">&lt;</a>
					</li>
					<c:forEach items="${sessionScope.pageInfo1.navigatepageNums}" var="i">
						<li ${i eq sessionScope.pageInfo1.pageNum?'class="active"':''}>
							<a href="/html/~power/powers?page=${i}">${i}</a>
						</li>
					</c:forEach>
					<li ${sessionScope.pageInfo1.pages eq sessionScope.pageInfo1.pageNum?'class="disabled"':''}>
						<a
								<c:if test="${sessionScope.pageInfo1.pages != sessionScope.pageInfo1.pageNum}">
									href="/html/~power/powers?page=${sessionScope.pageInfo1.nextPage}"
								</c:if>
						>&gt;</a>
					</li><!-- class="disabled" -->
				</ul>
			</div>
		</div>

		<!-- TODO 添加权限对话框部分-->
		<div class="modal fade" id="modal-add">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<span class="h3">
							<span class="glyphicon glyphicon-plus"></span> 新增权限
						</span>
					</div>
					<div class="modal-body">
						<form id="form-add" action="/html/~power/add" class="form-horizontal" method="post">
							<div class="form-group">
								<label class="col-xs-3 control-label">文本：</label>
								<div class="col-xs-9">
									<input class="form-control" required="required" name="title"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-xs-3 control-label">类别：</label>
								<div class="col-xs-9">
									<select class="form-control" name="typeId">
										<c:forEach items="${powerTypes}" var="pt">
											<option value="">未设置</option>
											<option value="${pt.id}">${pt.name}</option>
										</c:forEach>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-xs-3 control-label">URL：</label>
								<div class="col-xs-9">
									<input class="form-control" name="url"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-xs-3 control-label">描述：</label>
								<div class="col-xs-9">
									<input class="form-control" name="remark"></input>
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

		<!-- TODO 修改权限对话框部分-->
		<div class="modal fade" id="modal-edit">
			<div class="modal-dialog">
				<div class="modal-content">

				</div>
			</div>
		</div>

		<!-- TODO 权限类别管理modal部分 -->
		<div class="modal fade" id="modal-power-type">
			<div class="modal-dialog">
				<div class="modal-content">

				</div>
			</div>
		</div>
	</body>

</html>