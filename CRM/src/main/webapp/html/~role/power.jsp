<%@ page language="java" pageEncoding="utf-8" contentType="text/html;charset=UTF-8" %>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
    $(function () {
        setChkRootChecked();
    });

    //页面加载完成之后，判断在一个面板中所有权限都是勾选的，勾选对应的权限类别
    function setChkRootChecked() {
        var panels = $('#form-assign-power .panel');
        panels.each(function (i, panel) {
            var panel_heading = $(panel).find('.panel-heading');
            var panel_body = $(panel).find('.panel-body');
            var chkBoxRoot = panel_heading.find('input[type="checkbox"]')[0];
            var chkBoxes = panel_body.find('input[type="checkbox"]');

            var checked = true;
            chkBoxes.each(function (i, chk) {
                if (!chk.checked)
                    checked = false;
            });
            $(chkBoxRoot).attr('checked', checked);
        });
    }

    function setChkRootCheckedByPower(chkbox) {
        var $panel = $(chkbox).parents('.panel');

        var $chk = $panel.find('.panel-heading input[type="checkbox"]');
        var chk = $chk[0];
        var $chks = $panel.find('.panel-body input[type="checkbox"]');
        var flag = true;
        $chks.each(function (i, chk) {
            console.log(chk.checked);
            if (!chk.checked)
                flag = false;
        });

        chk.checked = flag;
    }

    function setChkeckBoxCheckedByRoot(chkbox) {
        var $panel = $(chkbox).parents('.panel');

        var $chk = $panel.find('.panel-heading input[type="checkbox"]');
        var chk = $chk[0];
        var $chks = $panel.find('.panel-body input[type="checkbox"]');
        $chks.each(function (i, e) {
            e.checked = chk.checked;
        });
    }
</script>

<div class="modal-header">
    <div class="modal-title">
        <span class="glyphicon glyphicon-eye-close"></span>
        <span>为角色分配权限</span>
        <span>-</span>
        <span>${role.name}</span>
    </div>
</div>

<div class="modal-body">
    <form action="/html/~role/assign" method="post" id="form-assign-power">
        <input type="hidden" name="roleId" value="${role.id}"/>
        <div class="panel-group">
            <c:forEach var="pt" items="${pts}">
                <div class="panel panel-info">
                    <div class="panel-heading">
                        <a href="#panel-${pt.id}" data-toggle="collapse" class="close">
                            <span class="caret"></span>
                        </a>

                        <div class="panel-title">
                            <label>
                                <input type="checkbox" onchange="setChkeckBoxCheckedByRoot(this)"/>
                                <span>${pt.name}</span>
                            </label>
                        </div>
                    </div>

                    <div id="panel-${pt.id}" class="collapse in">
                        <div class="panel-body">
                            <div class="container-fluid">
                                <div class="row">
                                    <c:forEach var="p" items="${pt.powers}">
                                        <div class="col-xs-6 col-sm-4 col-md-3">
                                            <label>
                                                <input type="checkbox" name="powers" value="${p.id}" ${p.checked?'checked':''}
                                                       onchange="setChkRootCheckedByPower(this)"/>
                                                <span>${p.title}</span>
                                            </label>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

    </form>
</div>

<div class="modal-footer">
    <button class="btn btn-default" data-dismiss="modal">
        <span class="glyphicon glyphicon-remove"></span>
        <span>关闭</span>
    </button>
    <button class="btn btn-primary" form="form-assign-power">
        <span class="glyphicon glyphicon-refresh"></span>
        <span>保存</span>
    </button>
</div>