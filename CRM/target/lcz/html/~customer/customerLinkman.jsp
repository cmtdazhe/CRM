<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
    $(function () {
        $(document).on('click', 'button[data-del-linkman]', function () {
            var id = $(this).data('del-linkman');
            var url = '/html/~cusromer/linkman-del-' + id;
            var del_btn = $(this);
            $.get(url, function () {
                $(del_btn).parents('tr').slideUp('fast', function () {
                    $(this).remove(2000); //tr的隐藏操作结束之后，将自己移除
                });
            });
        });
    });
</script>
<input type="hidden" value="${Linkcustomer.id}" id="customerId">
    <div class="modal-header">
        <button class="close" data-dismiss="modal">
            <span class="glyphicon glyphicon-remove"></span>
        </button>
        <h3 class="modal-title">
            客户联系人信息
            <div class="visible-xs"></div>
            <small>${Linkcustomer.name}</small>
            <small>
                <button class="btn btn-xs btn-primary" data-add-linkman="${Linkcustomer.id}">
                    <span class="glyphicon glyphicon-plus"></span>
                    <span class="hidden-xs">新增联系人</span>
                </button>
            </small>
        </h3>
    </div>

    <div class="modal-body">
        <table class="table table-condensed" id="table-add-linkman">
            <thead>
            <tr class="bg-info">
                <th>姓名</th>
                <th class="hidden-xs">性别</th>
                <th>职位</th>
                <th class="hidden-xs">办公电话</th>
                <th class="hidden-xs">移动电话</th>
                <th class="visible-xs">联系电话</th>
                <th class="hidden-xs">备注</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${linkmen}" var="l">
                <tr>
                    <td id="id1">${l.name}</td>
                    <td class="hidden-xs" id="id2">${l.sex}</td>
                    <td id="id3">${l.job}</td>
                    <td class="hidden-xs" id="id4">0730-${l.tel}</td>
                    <td class="hidden-xs" id="id5">${l.tel}</td>
                    <td class="hidden-xs" id="id6">${l.remark}</td>
                    <td>
                        <div class="btn-group btn-group-xs" data-id="100">
                            <button class="btn btn-default" data-toggle="modal" data-backdrop="false" data-edit-linkman="${l.id}">
                                <span class="glyphicon glyphicon-edit"></span>
                                <span class="hidden-xs">编辑</span>
                            </button>
                            <button class="btn btn-default del-linkman" data-del-linkman="${l.id}">
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
    </div>

    <div class="modal-footer">
        <button class="btn btn-default" type="button" data-dismiss="modal">
            <span class="glyphicon glyphicon-remove"></span>
            关闭
        </button>
    </div>


