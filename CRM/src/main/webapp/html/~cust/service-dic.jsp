<%@ page language="java" pageEncoding="utf-8" contentType="text/html;charset=UTF-8" %>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:if test="${null==pageInfo}">
	<c:redirect url="/html/~cust/services-two"/>
</c:if>
<html>

	<head>
		<title>客户关系管理系统-查看归档服务</title>
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
		<link rel="stylesheet" type="text/css" href="../../css/custom/html-cust-service.min.css" />

		<!--界面自定义JS文件-->
		<script src="../../js/custom/tip-popover.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="../../js/crmJs/service.js" type="text/javascript" charset="utf-8"></script>
<%--<script src="../../js/custom/html-cust-service.min.js" type="text/javascript" charset="utf-8"></script>--%>
	</head>

	<body>
		<div class="container-fluid">

			<!--TODO 当前页面地理位置 (面包屑导航)-->
			<ul class="breadcrumb">
				<li>服务管理</li>
				<li>查看归档服务</li>
			</ul>

			<!--TODO 搜索表单及工具按钮-->
			<form id="form-search" action="/html/~cust/services-two" method="post" class="form-inline">
				<input type="hidden" name="hiddintwo" value="hiddintwo">
				<div class="form-group">
					<label class="control-label">
						<span>客户编号</span>
					</label>
					<div class="input-group">
						<span class="input-group-addon">Hk</span>
						<input class="form-control" name="customerId" value="${customerId1}"/>
					</div>

					<label class="control-label">
						<span>客户名称</span>
					</label>
					<input class="form-control" name="name" value="${name1}"/>
				</div>

				<div class="form-group">
					<label class="control-label">
						<span>服务概要</span>
					</label>
					<input class="form-control" name="title" value="${title1}"/>

					<label class="control-label">
						<span>服务类型</span>
						<select class="form-control" name="type">
							<option value="">全部</option>
							<option value="咨询" ${(type1 eq '咨询')?'selected':''}>咨询</option>
							<option value="建议" ${(type1 eq '建议')?'selected':''}>建议</option>
							<option value="投诉" ${(type1 eq '投诉')?'selected':''}>投诉</option>
						</select>
					</label>

					<label class="control-label">
						<span>创建时间：</span>
					</label>
					<input class="form-control" type="date" name="createDate1" value="${createDate11}"/> -
					<input class="form-control" type="date" name="createDate2" value="${createDate21}"/>

					<label class="control-label">
						<span>状态</span>
					</label>
					<select class="form-control" name="status">
						<option class="text-warning" value="">全部</option>
						<option class="text-warning" value="2" ${status1 eq 2?'selected':''} >已处理</option>
						<option class="text-warning" value="3" ${status1 eq 3?'selected':''}>已完成</option>
					</select>
				</div>

				<div class="form-group btn-group">
					<button class="btn btn-default">
						<span class="glyphicon glyphicon-search"></span>
						<span>查询</span>
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
					<th>概要</th>
					<th>分配状态</th>
					<th class="hidden-xs">类型</th>
					<th class="hidden-xs">创建</th>
					<th>操作</th>
				</tr>
				</thead>

				<tbody>
				<c:forEach var="se" items="${pageInfo.list}">
				<tr>
					<td class="hidden-xs">${se.id}</td>
					<td>${se.cuName}</td>
					<td>${se.title}</td>
					<c:choose>
						<c:when test="${se.status eq 0}">
							<td>
								<div class="text-warning">
									<span>未分配</span>
								</div>
							</td>
						</c:when>
						<c:otherwise>
							<td>
								<div class="text-warning">
									<c:forEach items="${users}" var="user">
										<c:if test="${user.id==se.assignUserId}">
											<span>${user.name}</span>
										</c:if>
									</c:forEach>
									<f:formatDate value="${se.assignTime}" var="assignTime" pattern="yyyy-MM-dd HH:mm:ss"/>
									<span>${assignTime}</span>
								</div>
							</td>
						</c:otherwise>
					</c:choose>

					<td class="hidden-xs">${se.type}</td>
					<td class="hidden-xs">
						<c:forEach items="${users}" var="user">
							<c:if test="${user.id==se.creationUserId}">
								<span>${user.name}</span>
							</c:if>
						</c:forEach>
						<f:formatDate value="${se.creationTime}" var="createDate" pattern="yyyy-MM-dd HH:mm:ss"/>
						<span class="text-muted">[${createDate}]</span>
					</td>
						<td>
							<div class="btn-group btn-group-xs">
								<button class="btn btn-default" title="查看" data-toggle="modal" data-oppen-look-id="${se.id}">
									<span class="glyphicon glyphicon-search"></span>
									<span class="hidden-xs">查看</span>
								</button>
							</div>
						</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>

			<!--TODO 数据分页部分-->
			<div class="text-center">
				<ul class="pagination pagination-sm">
					<c:choose>
						<c:when test="${pageInfo.pageNum le 1}">
							<li class="disabled">
								<a>&lt;</a>
							</li>
						</c:when>
						<c:otherwise>
							<li>
								<a href="/html/~cust/services?page=${pageInfo.pageNum-1}">&lt;</a>
							</li>
						</c:otherwise>
					</c:choose>

					<c:forEach var="i" items="${pageInfo.navigatepageNums}">
						<c:choose>
							<c:when test="${pageInfo.pageNum eq i}">
								<li class="active">
									<a>${i}</a>
								</li>
							</c:when>
							<c:otherwise>
								<li>
									<a href="/html/~cust/services?page=${i}">${i}</a>
								</li>
							</c:otherwise>
						</c:choose>
					</c:forEach>

					<c:choose>
						<c:when test="${pageInfo.pageNum ge pageInfo.pages}">
							<li class="disabled">
								<a>&gt;</a>
							</li>
						</c:when>
						<c:otherwise>
							<li>
								<a href="/html/~cust/services?page=${pageInfo.pageNum+1}">&gt;</a>
							</li>
						</c:otherwise>
					</c:choose>
				</ul>
			</div>
		</div>

		<!-- TODO 查看信息modal部分 -->
		<div class="modal fade" id="modal-show">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">

				</div>
			</div>
		</div>

	</body>

</html>