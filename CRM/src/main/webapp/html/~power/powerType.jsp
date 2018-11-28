<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
$(function(){
    $('#form-add-power-type').submit(function () {
        var url='/html/~power/powerTypesAdd';
        var data = $(this).serialize(); //将表单序列化  属性=值&属性=值
        $.post(url, data,
            function (pt) {
                //将表单重置，将表单所在的div折叠

                //将表单重置(JQuery封装之后的form对象没有reset方法)
                //$(this).reset();
                //通过JQuery封装之后的form对象得到原始html form对象，再调用reset方法
                $('#form-add-power-type')[0].reset();

                $('#div-add-power-type').collapse('toggle');
                //使用JS脚本为table添加一行数据
                //数据内容显示pt对象中的属性值
                var tr = '<tr>' +
                    '<td>' +
                    '<span>' + pt.name + '</span>' +
                    '<form id="from-update-power-type-' + pt.id + '" action="" style="display: none" method="post">' +
                    '<div class="form-group form-group-sm">' +
                    '<input type="hidden" name="id" value="' + pt.id + '"/>' +
                    '<input type="text" name="name" value="' + pt.name + '" class="form-control" required="required">' +
                    '</div>' +
                    '</form>' +
                    '</td>' +
                    '<td width="140">' +
                    '<div class="btn-group btn-group-xs">' +
                    '<button data-edit-power-type-id="' + pt.id + '" class="btn btn-default">' +
                    '<span class="glyphicon glyphicon-edit"></span>' +
                    '<span class="hidden-xs">修改</span>' +
                    '</button>' +
                    '<button data-del-power-type-id="' + pt.id + '" class="btn btn-danger">' +
                    '<span class="glyphicon glyphicon-remove"></span>' +
                    '<span class="hidden-xs">删除</span>' +
                    '</button>' +
                    '</div>' +
                    '<div data-update-power-type="' + pt.id + '" class="btn-group btn-group-sm" style="display: none">' +
                    '<button form="from-update-power-type-' + pt.id + '" data-update-power-type="" class="btn btn-primary">' +
                    '<span class="glyphicon glyphicon-refresh"></span>' +
                    '<span>更新</span>' +
                    '</button>' +
                    '<button data-cancel-update-power-type="" class="btn btn-default">' +
                    '<span class="glyphicon glyphicon-repeat"></span>' +
                    '<span>取消</span>' +
                    '</button>' +
                    '</div>' +
                    '</td>' +
                    '</tr>';

                $('#table-power-type tbody').prepend(tr);
            },
            'json');
        return false;
    });


    $(document).on('click', 'button[data-del-power-type-id]', function () {
        var id = $(this).data('del-power-type-id');
        var url = '/html/~power/power-type-del-' + id;
        var del_btn = $(this);
        $.get(url, function () {
            //删除权限类别成功，将table中的指定tr移除
            $(del_btn).parents('tr').slideUp('fast', function () {
                $(this).remove(2000); //tr的隐藏操作结束之后，将自己移除
            });
        });
    });

    $(document).on('click', 'button[data-edit-power-type-id]', function () {
        var tr = $(this).parents('tr');
        var td1 = $(tr).find('td:first');
        var td2 = $(tr).find('td:last');

        td1.find('span').slideUp('fast');
        td1.find('form').slideDown('fast');

        td2.find('div:first').slideUp('fast');
        td2.find('div:last').slideDown('fast');
    });

    $(document).on('click', 'button[data-cancel-update-power-type]', function () {
        var tr = $(this).parents('tr');
        var td1 = $(tr).find('td:first');
        var td2 = $(tr).find('td:last');

        td1.find('span').slideDown('fast');
        td1.find('form').slideUp('fast');

        td2.find('div:first').slideDown('fast');
        td2.find('div:last').slideUp('fast');
    });

    $(document).on('click', 'button[data-update-power-type]', function () {
        var id = $(this).data('update-power-type');
        var form = $('#from-update-power-type-' + id);
        var url = '/html/~power/power-type-update';

        var tr = $(this).parents('tr');
        $.post(url, form.serialize(), function (pt) {
            var td1 = $(tr).find('td:first');
            var td2 = $(tr).find('td:last');

            td1.find('span').html(pt.name);
            td1.find('span').slideDown('fast');
            td1.find('form').slideUp('fast');

            td2.find('div:first').slideDown('fast');
            td2.find('div:last').slideUp('fast');
        });
        return false;
    });
});
</script>

<div class="modal-header">
    <div class="modal-title">
        <span class="glyphicon glyphicon-list"></span>
        <span>权限类别管理</span>
        <a href="#div-add-power-type" class="btn btn-xs btn-primary"
           data-toggle="collapse">
            <span class="glyphicon glyphicon-plus"></span>
            <span>新增</span>
        </a>
    </div>
</div>

<div class="modal-body">
    <div id="div-add-power-type" class="collapse">

        <!-- 添加权限类别表单 -->
        <form action="" method="post" id="form-add-power-type"
              class="form-horizontal">
            <div class="form-group form-group-sm">
                <label class="control-label col-xs-2">权限类别</label>
                <div class="col-xs-8">
                    <input type="text" class="form-control" name="name" required="required"/>
                </div>
                <div class="col-xs-2">
                    <button class="btn btn-primary">
                        <span class="glyphicon glyphicon-plus"></span>
                        <span>新增</span>
                    </button>
                </div>
            </div>
        </form>
        <h3></h3>
    </div>

    <table id="table-power-type" class="table table-hover table-condensed table-striped">
        <thead>
            <tr class="bg-info">
                <th>类别</th>
                <th width="140">操作</th>
            </tr>
        </thead>
        <tbody>
        <c:forEach var="pt" items="${pts}">
            <tr>
                <td>
                    <span>${pt.name}</span>
                    <form id="from-update-power-type-${pt.id}" action="" style="display: none">
                        <div class="form-group form-group-sm">
                            <input type="hidden" name="id" value="${pt.id}"/>
                            <input type="text" name="name" value="${pt.name}" class="form-control" required="required">
                        </div>
                    </form>
                </td>
                <td>
                    <div class="btn-group btn-group-xs">
                        <button data-edit-power-type-id="${pt.id}" class="btn btn-default">
                            <span class="glyphicon glyphicon-edit"></span>
                            <span class="hidden-xs">修改</span>
                        </button>
                        <button data-del-power-type-id="${pt.id}" class="btn btn-danger">
                            <span class="glyphicon glyphicon-remove"></span>
                            <span class="hidden-xs">删除</span>
                        </button>
                    </div>
                    <div data-update-power-type="${pt.id}" class="btn-group btn-group-sm" style="display: none">
                        <button form="from-update-power-type-${pt.id}" data-update-power-type="${pt.id}" class="btn btn-primary">
                            <span class="glyphicon glyphicon-refresh"></span>
                            <span>更新</span>
                        </button>
                        <button data-cancel-update-power-type="" class="btn btn-default">
                            <span class="glyphicon glyphicon-repeat"></span>
                            <span>取消</span>
                        </button>
                    </div>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<div class="modal-footer">
    <button class="btn btn-default" data-dismiss="modal">
        <span class="glyphicon glyphicon-remove"></span>
        <span>关闭</span>
    </button>
</div>