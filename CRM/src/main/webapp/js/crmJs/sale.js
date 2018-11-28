$(function () {
    //找到页面中“成功概率”滑块，绑定一个值改变事件
    $('input[type="range"]').on('input',function () {
        var spanId = $(this).data('target'); //#range_ds_1
        $(spanId).text('('+$(this).val()+'%)');
    });

    //指派咯
    $.getJSON('/html/~sale/users',function (users) {
        $('button[data-assign-sale]').popover({
            title:'指派',
            html:true,
            placement:'left',
            trigger:'click|focus',
            content:function () {
                var id = $(this).data('assign-sale');
                var alist = '<div class="list-group">';
                $(users).each(function (i, e) {
                    var uid = e.id;
                    var uname = e.name;
                    alist+='<a class="list-group-item" href="/html/~sale/assign-sale?id='+id+'&uid='+uid+'">'+uname+'</a>';
                });
                alist+='</div>';
                return alist;
            }
        });
    });

    //删除
    $(document).on('click','[data-del-sale]',function () {
        var id = $(this).data('del-sale');
        var url = '/html/~sale/del-sale-'+id;
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

    //修改
    $(document).on('click','[data-edit-sale]',function () {
        var id = $(this).data('edit-sale');
        var url = '/html/~sale/to-edit-'+id;
        //alert(url);为毛不回显
        $('#modal-edit .modal-content').load(url,function () {
            $('#modal-edit').modal('show');
        });
    });
});


    /*plan*/
    //查看页面
    $(document).on('click','[data-fond-dev]',function () {
        var opportunityId = $(this).data('fond-dev');
        var url = '/html/~sale/fondDev-'+opportunityId;
        $('#modal-show .modal-content').load(url, function () {
            $('#modal-show').modal('show');
        });
    });

    //计划
    $(document).on('click','[data-plan-dev]',function () {
        var opportunityId = $(this).data('plan-dev');
        var url = '/html/~sale/devPlan-'+opportunityId;
        $('#modal-plan .modal-content').load(url, function () {
            $('#modal-plan').modal('show');
        });
    });

    //删除
    $(document).on('click','[data-sale-dev]',function () {
       var id = $(this).data('sale-dev');
        $(this).popover({
            title: '提示',
            html: true,
            trigger: 'click|focus',
            placement: 'top',
            content: function () {
                var _this = this;
                var buttons = $.parseHTML('<div><button class="btn btn-success"><span class="glyphicon glyphicon-ok"></span> ' +
                    '<span class="hidden-xs">\u6210\u529F\uFF1F</span>' + '</button> ' +
                    '<button class="btn btn-danger"><span class="glyphicon glyphicon-remove"></span> ' +
                    '<span class="hidden-xs">\u5931\u8D25\uFF1F</span></button></div>');

                $(buttons).find('button:first').on('click', function() {
                    location.href='/html/~sale/edit-status?id='+id+'&status=2';
                });
                $(buttons).find('button:last').on('click', function() {
                    location.href='/html/~sale/edit-status?id='+id+'&status=3';
                });

                return buttons;
            }
        }).popover('show');

    });


