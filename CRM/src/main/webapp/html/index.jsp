<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
		<!-- 让主界面中的所有链接都在name="content"的iframe中打开 -->
		<base target="content" />
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />

		<title>客户关系管理系统</title>

		<link rel="shortcut icon" href="../favicon.ico" />

		<link rel="stylesheet" type="text/css" href="../css/bootstrap.min.css" />
		<link rel="stylesheet" type="text/css" href="../css/bootstrap-theme.min.css" />
		<link rel="stylesheet" type="text/css" href="../css/normalize.min.css" />

		<script src="../js/jquery-3.2.1.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="../js/bootstrap.min.js" type="text/javascript" charset="utf-8"></script>

		<!--[if lte IE 8]>
		<script src="../js/html5shiv.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="../js/respond.min.js" type="text/javascript" charset="utf-8"></script>
		<![endif]-->

		<!-- 界面自定义CSS文件 -->
		<link rel="stylesheet" type="text/css" href="../css/custom/scrollbar-style.min.css" />
		<link rel="stylesheet" type="text/css" href="../css/custom/html-index.min.css" />

		<!--界面自定义JS文件-->
		<script src="../js/custom/tip-modal.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="../js/custom/html-index.js" type="text/javascript" charset="utf-8"></script>
	</head>

	<body>
		<!--顶部导航条部分-->
		<div class="navbar navbar-default top-navbar">
			<div class="container-fluid">
				<div class="navbar-header">
					<!-- 响应式按钮 -->
					<button data-target=".nav-menu" data-toggle="collapse" class="navbar-toggle collapsed">
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
					</button>

					<!-- LOGO图标 -->
					<img src="../img/xxx.png" class="navbar-brand" style="padding: 0;" />
				</div>

				<div class="collapse navbar-collapse navbar-left nav-menu">
					<ul class="nav navbar-nav nav-pills">
						<c:forEach items="${pts}" var="pt">
							<li class="dropdown">
								<a href="#" class="dropdown-toggle" data-toggle="dropdown">
									<span>${pt.name}</span>
									<span class="caret"></span>
								</a>
								<ul class="dropdown-menu">
									<c:forEach items="${pt.powers}" var="p">
										<li>
											<a href="/html/${p.url}">${p.title}</a>
										</li>
									</c:forEach>
								</ul>
							</li>
						</c:forEach>

						<li>
							<a href="" class="dropdown-toggle" data-toggle="dropdown">
								<span class="glyphicon glyphicon-user"></span>
								<span class="hidden-xs">个人中心</span>
							</a>
							<ol class="dropdown-menu">
								<li>
									<a>
										<span class="text-success">${user.name}</span>(juese)
									</a>
								</li>
								<li>
									<a href="/html/login-off" target="_top">
										<span class="glyphicon glyphicon-log-out"></span>
										<span>退出系统</span>
									</a>
								</li>
							</ol>
						</li>
					</ul>
				</div>

			</div>
		</div>

		<!--主页内容部分-->
		<iframe name="content" src="welcome.html" frameborder="0">
			<center class="text-danger h1">您的浏览器不支持框架显示，请升级或更换浏览器！</center>
		</iframe>

		<!--页面底部版权部分-->
		<div class="navbar navbar-default navbar-fixed-bottom bottom-navbar">
			<div class="text-center navbar-text copy">
				it教育 2018
				</center>
			</div>
		</div>
	</body>
</html>