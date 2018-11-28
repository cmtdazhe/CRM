$(function () {
    $.getJSON('/html/~service/users',function (users) {
        //为“指派”按钮添加单击事件
        $('button[data-assign-sale]').popover({
            title:'指派',
            html:true,
            placement:'left',
            trigger:'click|focus',
            content:function () {
                //销售机会的编号
                var id = $(this).data('assign-sale');
                var alist = '<div class="list-group">';
                $(users).each(function (i, e) {
                    var uid = e.id; //用户的编号
                    var uname = e.name; //用户的名称
                    alist+='<a class="list-group-item" href="/html/~service/assign-service?id='+id+'&uid='+uid+'">'+uname+'</a>';
                });
                alist+='</div>';
                return alist;
            }
        });
    });

    $(document).on('click','button[data-oppen-look-id]',function () {
        var id = $(this).data('oppen-look-id');
        var url = "/html/~cust/look-service-"+id;
        $('#modal-show .modal-content').load(url,function () {
            $('#modal-show').modal('show');
        });
    });

    //处理
    $(document).on('click','button[data-service-exec]',function () {
        var id = $(this).data('service-exec');
        var url = "/html/~cust/to-edit-service-"+id;
        $('#modal-exec .modal-content').load(url,function () {
            $('#modal-exec').modal('show');
        });
    });

    $(document).on('click','button[data-del-service]',function () {
        var id = $(this).data('del-service');
        var url = "/html/~cust/del-service-"+id;
        $(this).popover({
            title:'删除',
            html:true,
            trigger:'focus|click',
            placement:'top',
            content:function () {
                var btn = $('<button class="btn btn-danger">删除?</button>');
                btn.click(function () {
                    window.location.href = url;
                });
                return btn;
            }
        }).popover('show');
    });


    $(document).on('click','[data-service-dic]',function () {
       var id = $(this).data("service-dic");
       var url = "/html/~cust/service-edit-dic-"+id;
        $(this).popover({
            title:'删除',
            html:true,
            trigger:'focus|click',
            placement:'top',
            content:function () {
                var _this = this;
                var button = $('<button class="btn btn-primary">\u5F52\u6863</botton>');
                button.click(function() {
                    $.get(url, function () {
                        $(_this).parents('tr:first').hide('slow', function() {
                            $(this).remove();
                            window.top.showTipSuccess();
                        });
                    });
                });
                return button;
            }
        }).popover('show');

    });
});