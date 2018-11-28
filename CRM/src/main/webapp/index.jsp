<%--
  Created by IntelliJ IDEA.
  User: 李承哲
  Date: 2018/11/5
  Time: 15:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    <title>客户关系管理系统-系统登录</title>

    <link rel="shortcut icon" href="img/favicon.ico" />

    <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="css/bootstrap-theme.min.css" />
    <link rel="stylesheet" type="text/css" href="css/normalize.min.css" />

    <script src="js/jquery-3.2.1.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="js/bootstrap.min.js" type="text/javascript" charset="utf-8"></script>

    <!-- 界面自定义CSS文件 -->
    <link rel="stylesheet" type="text/css" href="css/custom/scrollbar-style.min.css" />
    <link rel="stylesheet" type="text/css" href="css/custom/login.min.css" />
</head>

<body>
<div class="navbar navbar-default">
    <div class="container">
        <div class="navbar-header">
            <img class="navbar-brand" src="img/xxx.png" />
            <div class="navbar-brand">客户关系管理系统</div>
        </div>
    </div>
</div>

<div class="container-fluid">
    <div class="container text-center">

        <div class="login-form">
            <form action="/do-login" method="post">
                <div class="form-group form-group-sm">
                    <table>
                        <tr>
                            <td width="65" align="right">
                                <label class="control-label" for="name">登录名：</label>
                            </td>
                            <td>
                                <input name="login" id="name" class="form-control" required="required" autofocus="autofocus" />
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                <label class="control-label" for="pwd">密码：</label>
                            </td>
                            <td>
                                <input name="password" id="pwd" type="password" class="form-control" required="required" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" align="right">
                                <span class="text-danger">
									    &nbsp;&nbsp;${login_error}
                                </span>
                                <button class="btn btn-danger">
                                    登录
                                </button>
                            </td>
                        </tr>
                    </table>
                </div>
            </form>
        </div>

    </div>
</div>

<!--页面底部版权部分-->
<div class="navbar navbar-default navbar-fixed-bottom text-center">
    <div class="navbar-text" style="float: none;">
        &copy; 管理系统走你
    </div>
</div>
</body>
</html>
