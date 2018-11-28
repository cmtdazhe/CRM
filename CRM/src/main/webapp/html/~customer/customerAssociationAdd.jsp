<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script type="text/javascript">
    $(function () {
        $('#form-add-activity').submit(function () {
            var url = "/html/~customer/addAssociation";
            var id = $('#customerId').val();
            var data = $(this).serialize(); //将表单序列化  属性=值&属性=值
            $.post(url,data,function (association) {
                location.href="/html/~customer/association-"+id;
            },"json");
            window.top.showTipSuccess();
        });
    });
</script>
<form class="modal-content" id="form-add-activity">
    <input type="hidden" value="${customer.id}" name="customerId" id="customerId">
    <div class="modal-header">
        <button class="close" data-dismiss="modal">
            <span class="glyphicon glyphicon-remove"></span>
        </button>
        <h3 class="modal-title">
            新增客户交往记录
            <div class="visible-xs"></div>
            <small>${customer.name}</small>
        </h3>
    </div>
    <div class="modal-body">
        <div class="form-horizontal">
            <div class="form-group form-group-sm">
                <label class="col-xs-1 col-md-2 control-label">时间</label>
                <div class="col-xs-5 col-md-4">
                    <input class="form-control" type="date" required="required" name="creationTime" autofocus="autofocus" />
                </div>
            </div>

            <div class="form-group form-group-sm">
                <label class="col-xs-2 control-label">主题</label>
                <div class="col-xs-10">
                    <input class="form-control" name="title" required="required" />
                </div>
            </div>

            <div class="form-group form-group-sm">
                <label class="col-xs-2 control-label">地点</label>
                <div class="col-xs-10">
                    <input class="form-control" name="place" />
                </div>
            </div>

            <div class="form-group form-group-sm">
                <label class="col-xs-2 control-label">详细信息</label>
                <div class="col-xs-10">
                    <textarea class="form-control" name="remark"></textarea>
                </div>
            </div>
        </div>
    </div>
    <div class="modal-footer">
        <button class="btn btn-default" type="button" data-dismiss="modal">
            <span class="glyphicon glyphicon-remove"></span>
            关闭
        </button>
        <button class="btn btn-primary" type="submit">
            <span class="glyphicon glyphicon-save"></span>
            保存
        </button>
    </div>
</form>
