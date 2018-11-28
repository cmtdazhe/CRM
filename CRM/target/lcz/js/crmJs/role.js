$(function(){

    $(document).on('click','[data-role-edit]',function () {
        var id = $(this).data('role-edit');
        var url = '/html/~role/to-edit-' + id;

        $.getJSON(url, function(role) {

            $('#status_div').html('');
            $("#role_id").html(role.id);
            $('#modal-edit input[name="id"]').val(role.id);
            $('#modal-edit input[name="name"]').val(role.name);
            $('#modal-edit textarea[name="remark"]').val(role.remark);

            if(role.status){
                var div = '<label class="col-xs-3 control-label">标志：</label>\n' +
                    '<div class="col-xs-9 form-control-static">\n' +
                    '<span class="glyphicon glyphicon-ok text-success"></span>\n' +
                    '</div>';

            }else{
                var div = '<label class="col-xs-3 control-label">标志：</label>\n' +
                    '<div class="col-xs-9 form-control-static text-danger">\n' +
                    '<span class="glyphicon glyphicon-remove"></span>\n' +
                    '</div>';
            }
            $('#status_div').prepend(div);


            $('#modal-edit').modal('show'); //使用JS脚本显示模态框
        });
    });

    $(document).on('click','[data-role-status]',function () {
        var id = $(this).data('role-status');
        var url = '/html/~role/updateStatus-'+id;
        window.location.href = url; //将当前窗口地址导航到指定的URL
    });


    $(document).on('click','[data-del-id]',function () {
        var id = $(this).data('del-id');
        var url = '/html/~role/del-'+id;
        $(this).popover({
            title:'删除',
            html:true,
            trigger:'click|focus',
            placement: 'top',
            content:function () {
                //return '<a href="'+url+'" class="btn btn-danger">删除？</a>'
                var btn = $('<button class="btn btn-danger">删除?</button>');
                btn.click(function () {
                    $(this).remove();
                    window.location.href = url;
                    window.top.showTipSuccess();
                });
                return btn;
            }
        }).popover('show');
    });

    $(document).on('click', 'button[data-assign]', function () {
        var id = $(this).data('assign');
        var url = '/html/~role/to-assign-' + id;
        $('#modal-assign-power .modal-content').load(url, function () {
            $('#modal-assign-power').modal('show');
        });
    });
});