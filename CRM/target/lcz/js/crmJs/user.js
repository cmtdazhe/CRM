$(function(){
   $(document).on('click','[data-user-del]',function () {
       var id = $(this).data('user-del');
       var url = '/html/~user/del-'+id;
       $(this).popover({
           title: '删除',
           html: true,
           trigger: 'click|focus',
           placement: 'top',
           content: function () {
               //return '<a href="'+url+'" class="btn btn-danger">删除？</a>';
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


   $(document).on('click','[data-user-status]',function () {
       var id = $(this).data('user-status');
       var url = '/html/~user/updataStatus-'+id;
       window.location.href = url; //将当前窗口地址导航到指定的URL
   });

   $(document).on('click','[data-user-edit]',function () {
      var id = $(this).data('user-edit');
      var url = '/html/~user/to-edit-'+id;
       $('#modal-edit .modal-content').load(url, function () {
           $('#modal-edit').modal('show');
       });
   });
});