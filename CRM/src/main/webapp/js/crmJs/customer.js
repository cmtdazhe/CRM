/*客户信息管理*/
$(function () {

    $(document).on('click','[data-customer-show]',function () {
        var id = $(this).data('customer-show');
        var url = "/html/~customer/customer-show-"+id;
        $('#modal-show .modal-content').load(url, function () {
            $('#modal-show').modal('show');
        });
    });

    $(document).on('click','[data-customer-edit]',function () {
        var id = $(this).data('customer-edit');
        var url = "/html/~customer/to-edit-"+id;
        $('#modal-edit .modal-content').load(url, function () {
            $('#modal-edit').modal('show');
        });
    });

    $(document).on('click','[data-customer-linkman]',function () {
        var id = $(this).data('customer-linkman');
        var url = "/html/~customer/linkman-"+id;
        $('#modal-linkman .modal-content').load(url, function () {
            $('#modal-linkman').modal('show');
        });
    });

    //头晕了。。。。。。。。。。。。。。。分层。。。。。。。。。。。。。。


    /*新增联系人*/
    $(document).on('click','[data-add-linkman]',function () {
        var id = $(this).data('add-linkman');
        var url = "/html/~customer/to-add-linkman-"+id;
        $.getJSON(url, function (customer) {
            $('#customerId').html(customer.id);
            $('#names').html(customer.name);
            $('#modal-add-linkman').modal('show');
        });
    });
    $('#btnSubmit').click(function () {
        var customerId = $('#customerId').val();
        var name = $('#name').val();
        var sex = $('#form-add-linkman input[name=sex]').val();
        var job = $('#job').val();
        var tel = $('#tel').val();
        var remark=$('#remark').val();
        var url = "/html/~customer/addLinkman?customerId="+customerId+"&name="+name+"&job="+job+"&tel="+tel+"&sex="+sex+"&remark="+remark;
        $.post(url,function (linkman) {
            var tr=' <tr>\n' +
                '                    <td>'+linkman.name+'</td>\n' +
                '                    <td class="hidden-xs">'+linkman.sex+'</td>\n' +
                '                    <td>'+linkman.job+'</td>\n' +
                '                    <td class="hidden-xs">0730-'+linkman.tel+'</td>\n' +
                '                    <td class="hidden-xs">'+linkman.tel+'</td>\n' +
                '                    <td class="hidden-xs">'+linkman.remark+'</td>\n' +
                '                    <td>\n' +
                '                        <div class="btn-group btn-group-xs" data-id="100">\n' +
                '                            <button class="btn btn-default" data-toggle="modal" data-backdrop="false" data-edit-linkman="'+linkman.id+'">\n' +
                '                                <span class="glyphicon glyphicon-edit"></span>\n' +
                '                                <span class="hidden-xs">编辑</span>\n' +
                '                            </button>\n' +
                '                            <button class="btn btn-default del-linkman" data-del-linkman="'+linkman.id+'">\n' +
                '                                <div class="text-danger">\n' +
                '                                    <span class="glyphicon glyphicon-remove"></span>\n' +
                '                                    <span class="hidden-xs">删除</span>\n' +
                '                                </div>\n' +
                '                            </button>\n' +
                '                        </div>\n' +
                '                    </td>\n' +
                '                </tr>';
            $('#modal-add-linkman input').val('');
            $('#modal-add-linkman textarea').val('');
            $('#table-add-linkman tbody').prepend(tr);
        });
        window.top.showTipSuccess();
        $('#modal-add-linkman').modal('hide');
    });
    //去修改联系人，数据回显
    $(document).on('click','[data-edit-linkman]',function () {
        var id = $(this).data('edit-linkman');
        var url = "/html/~customer/to-edit?id="+id;
        $.getJSON(url, function (linkman) {
            $('#form-edit-linkman input[name=id]').val(linkman.id);
            $('#form-edit-linkman input[name=name]').val(linkman.name);
            $('#form-edit-linkman input[name=job]').val(linkman.job);
            $('#form-edit-linkman input[name=tel]').val(linkman.tel);
            $('#form-edit-linkman textarea[name=remark]').val(linkman.remark);

            $('#modal-edit-linkman').modal('show');
        });
    });
    /*修改联系人*/
    $('#form-edit-linkman').submit(function () {
        var url = "/html/~cusromer/linkman-edit";
        var customerId = $('#customerId').val();
        var data = $(this).serialize(); //将表单序列化  属性=值&属性=值
        $.post(url,data,function (linkman) {
            location.href="/html/~customer/to-add-linkman-"+customerId;
        },"json");
        window.top.showTipSuccess();
        $('#modal-edit-linkman').modal('hide');
    });


    //。。。。。。。。。。。。。。。。。。。。。。。。。。。

    //添加交往记录
    $(document).on('click','[data-add-association]',function(){
        var id = $(this).data('add-association');
        var url = '/html/~customer/to-add-association-'+id;
        $.getJSON(url,function (customer) {
            $('#customerIds').val(customer.id);
            $('#customerName').html(customer.name+"  "+customer.id);
            $('#modal-add-activity').modal('show');
        });
    });
    $('#activitySubimt').click(function () {
        var id = $('#form-add-activity input[name=customerId]').val();
        var creationTime = $('#form-add-activity input[name=creationTime]').val();
        var title = $('#form-add-activity input[name=title]').val();
        var place = $('#form-add-activity input[name=place]').val();
        var remark = $('#form-add-activity textarea[name=remark]').val();
        var url = "/html/~customer/addAssociation?customerId="+id+"&creationTime="+creationTime+"&title="+title+"&place="+place+"&remark="+remark;
        $.getJSON(url,function (association) {
            var date = new Date(association.creationTime);
            Y = date.getFullYear() + '/';
            M = (date.getMonth()+1 < 10 ? '0'+(date.getMonth()+1) : date.getMonth()+1) + '/';
            D = date.getDate() + ' ';
            var createDate = (Y+M+D);
            var tr = ' <tr>\n' +
                '                <td>'+createDate+'</td>\n' +
                '                <td>'+association.title+'</td>\n' +
                '                <td>'+association.place+'</td>\n' +
                '                <td>'+association.remark+'</td>\n' +
                '                <td data-id="100">\n' +
                '                    <button class="btn btn-xs btn-danger del-activity" data-del-association="'+association.id+'">\n' +
                '                        <span class="glyphicon glyphicon-remove"></span>\n' +
                '                        <span class="hidden-xs">删除</span>\n' +
                '                    </button>\n' +
                '                </td>\n' +
                '            </tr>';
            $('#form-add-activity input').val('');
            $('#form-add-activity textarea').val('');
            $('#table-ass tbody').prepend(tr);
        });
        window.top.showTipSuccess();
        $('#modal-add-activity').modal('hide');
    });
    //交往记录模块
    $(document).on('click','[data-customer-assciation]',function(){
       var id = $(this).data('customer-assciation');
       var url = '/html/~customer/association-'+id;
       $('#modal-activites .modal-content').load(url,function () {
          $('#modal-activites').modal('show');
       });
    });
    //删除的在主页面

    //流失
    $(document).on('click','[data-edit-status]',function(){
        var id = $(this).data('edit-status');
        var url = '/html/~customer/edit-status-'+id;
        $(this).popover({
            title: '删除',
            html: true,
            trigger: 'click|focus',
            placement: 'top',
            content: function () {
                var btn = $('<button class="btn btn-danger">确认标记为流失？</button>"');
                btn.click(function () {
                    $(this).remove();
                    window.location.href = url; //将当前窗口地址导航到指定的URL
                    window.top.showTipSuccess();
                });
                return btn;
            }
        }).popover('show');
    });

});
