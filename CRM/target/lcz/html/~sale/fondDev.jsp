<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="../../css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="../../css/bootstrap-theme.min.css" />
<link rel="stylesheet" type="text/css" href="../../css/normalize.min.css" />

<!-- 界面自定义CSS文件 -->
<link rel="stylesheet" type="text/css" href="../../css/custom/scrollbar-style.min.css" />
<link rel="stylesheet" type="text/css" href="../../css/custom/html-sale-dev.min.css" />

<script src="../../js/jquery-3.2.1.min.js" type="text/javascript" charset="utf-8"></script>
<script src="../../js/bootstrap.min.js" type="text/javascript" charset="utf-8"></script>

<!--[if lte IE 8]>
<script src="../../js/html5shiv.min.js" type="text/javascript" charset="utf-8"></script>
<script src="../../js/respond.min.js" type="text/javascript" charset="utf-8"></script>
<![endif]-->
<div class="modal-header">
    <button class="close" data-dismiss="modal">
        <span class="glyphicon glyphicon-remove"></span>
    </button>
    <h3 class="modal-title">客户开发详情</h3>
</div>
<div class="modal-body">
    <div>
        <!--客户机会详情-->
        <table data-name="data" class="table table-condensed">
            <tbody>
            <tr>
                <th class="bg-info">
                    <span>编号</span>
                </th>
                <td>${salesOpportunity.id}</td>
                <th class="bg-info">
                    <span class="hidden-xs">机会来源</span>
                    <span class="visible-xs">来源</span>
                </th>
                <td>${salesOpportunity.source}</td>
            </tr>
            <tr>
                <th class="bg-info">
                    <span class="hidden-xs">客户名称</span>
                    <span class="visible-xs">客户</span>
                </th>
                <td>${salesOpportunity.customerName}</td>
                <th class="bg-info">
                    <span class="hidden-xs">成功机率</span>
                    <span class="visible-xs">机率</span>
                </th>
                <td>${salesOpportunity.rate}%</td>
            </tr>
            <tr>
                <th class="bg-info">
                    <span>概要</span>
                </th>
                <td>${salesOpportunity.title}</td>
                <th class="bg-info">
                    <span class="hidden-xs">开发状态</span>
                    <span class="visible-xs">状态</span>
                </th>
                <td>
                    <c:if test="${salesOpportunity.status == 1}">
                        <span class="text-primary">开发中</span>
                    </c:if>
                    <c:if test="${salesOpportunity.status == 2}">
                        <span class="text-success">开发成功</span>
                    </c:if>
                    <c:if test="${salesOpportunity.status == 3}">
                        <span class="text-danger">开发失败</span>
                    </c:if>
                </td>
            </tr>
            <tr>
                <th class="bg-info">
                    <span>联系人</span>
                </th>
                <td>${salesOpportunity.creationUserId}</td>
                <th class="bg-info">
                    <span class="hidden-xs">联系电话</span>
                    <span class="visible-xs">电话</span>
                </th>
                <td>${salesOpportunity.tel}</td>
            </tr>
            <tr>
                <th class="bg-info">
                    <span class="hidden-xs">机会描述</span>
                    <span class="visible-xs">描述</span>
                </th>
                <td colspan="3">${salesOpportunity.remark}</td>
            </tr>
            <tr>
                <th class="bg-info">
                    <span>创建人</span>
                </th>
                <td>${salesOpportunity.creationUserName}</td>
                <th class="bg-info">
                    <span class="hidden-xs">创建时间</span>
                    <span class="visible-xs">时间</span>
                </th>
                <f:formatDate value="${salesOpportunity.creationTime}" var="createTime" pattern="yyyy/MM/dd HH:mm:ss"/>
                <td>
                    <span>${createTime}</span>
                </td>
            </tr>
            <tr>
                <th class="bg-info">
                    <span>指派给</span></th>
                <td>${salesOpportunity.assignUserName}</td>
                <th class="bg-info">
                    <span class="hidden-xs">指派时间</span>
                    <span class="visible-xs">时间</span>
                </th>
                <f:formatDate value="${salesOpportunity.assignTime}" var="assignTime" pattern="yyyy/MM/dd HH:mm:ss"/>
                <td>
                    <span>${assignTime}</span>
                </td>
            </tr>
            </tbody>
        </table>

       <!--计划-->
        <table data-name="plan" class="table table-condensed">
            <thead>
            <tr class="bg-info">
                <th>日期时间</th>
                <th>计划内容</th>
                <th>执行结果</th>
            </tr>
            </thead>

            <tbody>
            <c:forEach items="${salesPlans}" var="s">
                <f:formatDate value="${s.creationTime}" var="createDate" pattern="yyyy/MM/dd HH:mm:ss"/>
                <tr ${s.result eq null? 'class="bg-warning"':''}>
                    <td>${createDate}</td>
                    <td>${s.process}</td>
                    <td>
                        <c:if test="${s.result == null}">
                            <span class="text-warning">[未执行]</span>
                        </c:if>
                        <c:if test="${s.result != null}">
                            ${s.result}
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
<div class="modal-footer">
    <button class="btn btn-default" type="button" data-dismiss="modal">
        <span class="glyphicon glyphicon-remove"></span>
        关闭
    </button>
</div>
