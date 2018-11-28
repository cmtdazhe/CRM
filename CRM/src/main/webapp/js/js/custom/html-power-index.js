$(function() {
	//禁用 或 启用 按钮单击
	$('.power-table .btn-group>button:nth-child(2)').click(function() {
		//要禁用或启用的权限对象的编号
		var id = $(this).parent().data('id');

		//提交数据到Action更新权限对象的flag属性
		//如果更新完成，执行以下代码给与用户提示信息
		//如果更新失败，同样给与用户提示信息

		//该方法定义在tip-modal.js脚本文件中
		//而这个脚本文件却是在/html/index.html页面中引用，为什么呢？
		//因为，要index.html页面中引用，即使框架页面刷新了，也不会影响提示
		window.top.showTipSuccess();

		//显示操作失败的提示消息框
		//window.top.showTipFail();

		//再刷新当前ifream
		window.location.reload();
	});

	//删除按钮单击(严格来说，不推荐对数据进行delete操作，你要不听就当我没说)
	$('.power-table .btn-group>button:last-child').click(function() {
		$(this).tipPopover({
			'placement': 'top',
			'trigger': 'click|focus',
			'content': function() {
				var _this = this;
				var button = $('<button class="btn btn-danger">\u5220\u9664\uFF1F</botton>');
				button.click(function() {
					//要删除的权限对象的编号
					var id = $(this).parent().data('id');
					
					$(_this).parents('tr:first').hide('slow', function() {
						$(this).remove();
						//提交数据到Action更新权限对象的flag属性
						//如果更新完成，执行以下代码给与用户提示信息
						if(window.top.showTipSuccess)
							window.top.showTipSuccess();
				
						//显示操作失败的提示消息框
						//window.top.showTipFail();
				
						//再刷新当前ifream
						//window.location.reload();
					});
					
				});
				return button;
			}
		}).popover('show');

	});

	$('#form-type-add').submit(function() {
		var id = (~~(Math.random() * 10000));
		var val = $(this).find('input').val();
		if(val) {
			var tr = '<tr>' +
				'<td>' + id + '</td>' +
				'<td>' +
				'<div class="form-group form-group-xs">' +
				'<span class="form-control-static">' + val + '</span>' +
				'<input class="form-control input-sm" value="' + val + '" />' +
				'</div>' +
				'</td>' +
				'<td>' +
				'<div class="btn-group btn-group-xs">' +
				'<button class="btn btn-default"> ' +
				'<span class="glyphicon glyphicon-edit"></span> ' +
				'<span class="hidden-xs">\u4FEE\u6539</span>' +
				'</button>' +
				'<button class="btn btn-default">' +
				'<div class="text-danger">' +
				'<span class="glyphicon glyphicon-remove"></span> ' +
				'<span class="hidden-xs">\u5220\u9664</span>' +
				'</div>' +
				'</button>' +
				'</div>' +
				'<div class="btn-group btn-group-sm">' +
				'<button class="btn btn-sm btn-primary">' +
				'<span class="glyphicon glyphicon-edit"></span> ' +
				'<span class="hidden-xs">\u66F4\u65B0</span>' +
				'</button>' +
				'<button class="btn btn-default">' +
				'<span class="glyphicon glyphicon-repeat"></span> ' +
				'<span class="hidden-xs">\u53D6\u6D88</span>' +
				'</button>' +
				'</div>' +
				'</td>' +
				'</tr>';
			$('.type-table tbody').prepend(buildPowerTypeOption(tr));
		}
		$(this).collapse('hide');
		this.reset();
		event.preventDefault();
	});

	buildPowerTypeOption();
});

function buildPowerTypeOption(tr) {
	var $trs;

	if(!tr) {
		$trs = $('.type-table>tbody>tr');
	} else {
		$trs = $(tr);
	}

	$trs.each(function(i, tr) {
		var $tr = $(tr);
		var $span = $tr.find('td:nth-child(2)>div>span');
		var $input = $tr.find('td:nth-child(2)>div>input');
		var $btnGroup1 = $tr.find('td:last-child>.btn-group-xs');
		var $btnGroup2 = $tr.find('td:last-child>.btn-group-sm');
		var $btnEdit = $btnGroup1.find('.btn:first');
		var $btnRemove = $btnGroup1.find('.btn:last-child');
		var $btnUpdate = $btnGroup2.find('.btn:first');
		var $btnCancel = $btnGroup2.find('.btn:last-child');

		$input.slideToggle(0);
		$btnGroup2.slideToggle(0);

		$btnEdit.unbind().click(function() {
			$span.slideToggle(0);
			$input.slideToggle(0,function() {
				$(this).select();
			});

			$btnGroup1.slideToggle('fast');
			$btnGroup2.slideToggle('fast');
		});

		$btnRemove.unbind().click(function() {
			$tr.hide('slow', function() {
				$(this).remove();
			});
		});
		
		$btnUpdate.click(function(){
			var val=$input.val();
			if(val){
				$span.text(val);
				$btnCancel.click();
			}
		});

		$btnCancel.unbind().click(function() {
			$span.slideToggle(0);
			$input.slideToggle(0);
			$btnGroup1.slideToggle('fast');
			$btnGroup2.slideToggle('fast');
		});
	});

	return $trs;
}