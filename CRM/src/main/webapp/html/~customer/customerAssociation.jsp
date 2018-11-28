<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script type="text/javascript">
    $(function () {
        $(document).on('click', 'button[data-del-association]', function () {
            var id = $(this).data('del-association');
            var url = '/html/~cusromer/association-del-' + id;
            var del_btn = $(this);
            $.get(url, function () {
                //删除权限类别成功，将table中的指定tr移除
                $(del_btn).parents('tr').slideUp('fast', function () {
                    $(this).remove(2000); //tr的隐藏操作结束之后，将自己移除
                });
            });
        });
    });
</script>
<div class="modal-header">
    <button class="close" data-dismiss="modal">
        <span class="glyphicon glyphicon-remove"></span>
    </button>
    <h3 class="modal-title">
        客户交往记录
        <div class="visible-xs"></div>
        <small>${customer.name}</small>
        <button class="btn btn-xs btn-primary" data-toggle="modal" data-add-association="${customer.id}">
            <span class="glyphicon glyphicon-plus"></span>
            <span class="hidden-xs">新增交往记录</span>
        </button>
    </h3>
</div>
<div class="modal-body">
    <table class="table table-hover table-condensed" id="table-ass">
        <thead>
        <tr class="bg-info">
            <th>时间</th>
            <th>主题</th>
            <th>地点</th>
            <th>详细信息</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${as}" var="a">
            <f:formatDate value="${a.creationTime}" var="createDate" pattern="yyyy/MM/dd"/>
            <tr>
                <td>${createDate}</td>
                <td>${a.title}</td>
                <td>${a.place}</td>
                <td>${a.remark}</td>
                <td data-id="100">
                    <button class="btn btn-xs btn-danger del-activity" data-del-association="${a.id}">
                        <span class="glyphicon glyphicon-remove"></span>
                        <span class="hidden-xs">删除</span>
                    </button>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<div class="modal-footer">
    <button class="btn btn-default" type="button" data-dismiss="modal">
        <span class="glyphicon glyphicon-remove"></span>
        关闭
    </button>
</div>
