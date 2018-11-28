/* *
 * 应用在 /html/~sale/index.html页面
 * encoding:utf-8
 * */

$(function() {
	var userItems = [{
		"id": 100,
		"name": "李天明"
	}, {
		"id": 101,
		"name": "王大海"
	}, {
		"id": 102,
		"name": "张权副"
	}, {
		"id": 103,
		"name": "刘冬生"
	}, {
		"id": 104,
		"name": "杨树"
	}];

	//所有“指派”按钮获得焦点后显示可指派的人员列表
	$('.btn-group-xs>.btn:first-child').tipPopover({
		'placement': 'left',
		'content': function() {
			var _this = this;
			//组织将要显示的弹出框显示内容
			//从单击的按钮中得到data-id(销售机会)编号
			var id = $(this).parent().data('id');

			var div;
			if(!userItems) {
				div = $.parseHTML('<h4 class="text-muted">正在加载数据...</h4>');
				return div;
			} else {
				div = $($.parseHTML('<div class="list-group"></div>'));
				$.map(userItems, function(e) {
					div.append($.parseHTML('<a href="" data-id="' + e.id + '" class="list-group-item">' + e.name + '</a>'));
				});

				div.find('a').click(function() {
					dispatchItem(id, $(this).data('id'));
					event.preventDefault();
				});
			}

			return div;
		}
	});

	//所有“编辑”按钮单击事件
	$('.btn-group-xs>.btn:nth-child(2)').click(function() {
		//销售机会id
		var id = $(this).parent().data('id');

		//通过id值查询销售机会JSON格式数据，再将值设置到dialog中，并显示dialog
		// 比如
		$('#modal-edit [name="id"]').val(id); //将id值保存在隐藏域中
		$('#modal-edit #edit-title-id').text(id); //将id值显示在标题中
		//.....其它【省略】

		$('#modal-edit').modal('toggle');
	});

	//所有“删除”按钮单击事件
	$('.btn-group-xs>.btn:last-child').tipPopover({
		'placement': 'top',
		'content': function() {
			//组织将要显示的弹出框显示内容
			//从单击的按钮中得到data-id(销售机会)编号
			var id = $(this).parent().data('id');
			var _this = this;

			var button = $('<button class="btn btn-danger">\u5220\u9664\uFF1F</button>');
			button.click(function() {
				$(_this).parents('tr').fadeOut('slow',function(){
					if(window.top.showTipSuccess){
						//删除操作成功显示 Success提示
						window.top.showTipSuccess();

						//如果操作失败则显示Fail提示
						//window.top.showTipFail();

						//框架页面刷新
						//window.location.reload();
					}
					$(this).remove();
				});
			});
			return button;
		}
	});

	//界面中的 input[type="range"] 标签，在添加和修改销售机会对话框中有使用
	//在滑动滑块时，显示滑块的值
	$('input[type="range"]').on('input', function() {
		var target = $(this).data('target');
		if(target) {
			$(target).text($(this).val() + '%');
		}
	});
});

//为销售机会指派业务员(销售机会编号, 业务员编号)
function dispatchItem(cid, uid) {
	//cid-将销售机会
	//uid-指派给业务员

	//提交数据到服务器完成将销售机会指派给业务的操作

	//指派操作成功显示 Success提示
	//该方法定义在tip-modal.js脚本文件中
	//而这个脚本文件却是在/html/index.html页面中引用，为什么呢？
	//因为，要index.html页面中引用，即使框架页面刷新了，也不会影响提示
	window.top.showTipSuccess();

	//如果操作失败则显示Fail提示
	//window.top.showTipFail();

	//框架页面刷新
	window.location.reload();
}