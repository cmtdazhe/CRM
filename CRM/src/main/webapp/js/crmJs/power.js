$(function () {
    $(document).on('click', '[data-del-id]', function () {
        var id = $(this).data('del-id');
        var url = '/html/~power/del-' + id;
        $(this).popover({
            title: '删除',
            html: true,
            trigger: 'click|focus',
            placement: 'top',
            content: function () {
                var btn = $('<button class="btn btn-danger">删除？</button>"');
                btn.click(function () {
                    //弹出框中的按钮的单击事件
                    $(this).remove();
                    window.location.href = url; //将当前窗口地址导航到指定的URL
                    window.top.showTipSuccess();
                });
                return btn;
            }
        }).popover('show');
    });

    $(document).on('click','[data-edit-status]',function () {
        var id = $(this).data('edit-status');
        var url = '/html/~power/updateStatus-'+id;
        window.location.href = url; //将当前窗口地址导航到指定的URL
    });

    $(document).on('click','[data-power-edit]',function () {
        var id = $(this).data('power-edit');
        var url = '/html/~power/to-edit-'+id;
        $('#modal-edit .modal-dialog .modal-content').load(url,function () {
            $('#modal-edit').modal('show');
        })
    });

    $(document).on('click', 'button[data-power-type]', function () {
        var url = '/html/~power/powertypes';
        $('#modal-power-type .modal-dialog .modal-content').load(url, function () {
            $('#modal-power-type').modal('show');
        });
    });
});









