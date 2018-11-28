function buildTipPopover(objs, id) {
	$(objs).each(function(i, e) {
		$(e).tipPopover({
			'content': function() { //组织将要显示的弹出框显示内容
				var _this = this;

				var buttons = $.parseHTML('<button data-popover-del="true" class="btn btn-danger" data-id="' +
					id + '">\u5220\u9664\uFF1F</button>');

				$(buttons).first().click(function() {
					del_plan(_this);
				});

				return buttons;
			}
		});
	});
}

$(function() {
	//查看对话框中“正在加载数据...”层
	var $load_layer_show = $('#modal-show .modal-body>div:first-child');
	//查看对话框中数据层
	var $data_layer_show = $('#modal-show .modal-body>div:last-child');

	//制定计划对话框中“正在加载数据...”层
	var $load_layer_plan = $('#modal-plan .modal-body>div:first-child');
	//制定计划对话框中数据层
	var $data_layer_plan = $('#modal-plan .modal-body>div:last-child');

	//制定计划对话框中“正在加载数据...”层
	var $load_layer_plan_exec = $('#modal-plan-exec .modal-body>div:first-child');
	//制定计划对话框中数据层
	var $data_layer_plan_exec = $('#modal-plan-exec .modal-body>div:last-child');

	//查询销售机会详细信息对话框
	$('#modal-show').on('show.bs.modal', function() {
			$load_layer_show.show(); //显示“正在加载数据...”层
			$data_layer_show.hide(); //隐藏数据层
		})
		.on('shown.bs.modal', function(event) {
			//要操作的销售机会id
			var id = $(event.relatedTarget).parent().data('id');

			//从服务器通过id查询销售机会的详细信息，返回JSON数据
			//演示版效果为测试写法(数据内容全部是测试数据)，你应该从服务器中根据id值获取有效的数据
			//$.getJSON('../../data/test.json', function(data) {
			//data是服务器返回的根据id查询到的销售机会的JSON格式数据(这里是演示效果，是无效的)
			//你应该从服务器获取正确有效的数据内容，再将内容一一保存在modal对话框的对应控件中【保存数据部分代码省略】
			//比如
			//$('#modal-show #sale_id').text(data.id)
			//......
			//基础信息保存完成后，还要查询并循环保存计划数据信息，不要忘记了选择清空原有数据行再，添加新数据行
			//比如(添加一行)
			//var tbody = $('#modal-show table[data-name="plan"]>tbody')
			//tbody.find('tr').remove() //清空原有数据行
			//tbody.append('<tr><td>2017/12/07</td><td>初步接触，了解客户意向。</td>'+
			//	'<td>了解到客户季度末有采购需求。</td></tr>')
			//....

			//演示效果
			$load_layer_show.slideUp('fast'); //隐藏“正在加载数据...”层
			$data_layer_show.slideDown('fast'); //显示数据内容层
			//});

		});

	//制定计划对话框(模式与查询对话框相似)
	$('#modal-plan').on('show.bs.modal', function() {
			$load_layer_plan.show(); //显示“正在加载数据...”层
			$data_layer_plan.hide(); //隐藏数据层
		})
		.on('shown.bs.modal', function(e) {
			//要操作的销售机会id
			var id = $(e.relatedTarget).parent().data('id');

			//参考查看对话框中的操作
			//要注意：已执行的计划不显示删除按钮，只有未执行的计划才会显示删除按钮
			//$.getJSON('../../data/test.json', function(data) {
				$load_layer_plan.slideUp('fast'); //隐藏“正在加载数据...”层
				$data_layer_plan.slideDown('fast'); //显示数据内容层

				//设置显示数据及循环添加计划数据....

				//处理“删除计划”按钮，单击后显示一个弹出框，再单击弹出框中的“删除？”才会执行删除操作
				buildTipPopover($('#modal-plan .btn-plan-del'), id);
				/*$('#modal-plan .btn-plan-del').tipPopover({
					'content': function() { //组织将要显示的弹出框显示内容
						var _this = this;

						var buttons = $.parseHTML('<button data-popover-del="true" class="btn btn-danger" data-id="' +
							id + '">\u5220\u9664\uFF1F</button>');

						$(buttons).first().click(function() {
							del_plan(_this);
						});

						return buttons;
					}
				});*/

				//处理“新增开发计划”表单
				$('#modal-plan form').data('id', id).unbind().submit(function() {
					//计划标题
					var $title = $('#modal-plan form [name="plan.title"]');
					var title = $title.val();
					var id = $(this).data('id');

					//将计划标题提交到服务器完成添加计划操作
					/*$.post('服务器添加计划的Action地址',{},function(data){
						if(data.success){
							//操作成功，则将返回的计划信息作为tr对象添加到表格中
						}else{
							//操作失败，给出提示
							window.showTipFail();
						}
					});*/

					//以下是演示添加tr对象
					var test_id = (~~(Math.random() * 100000)); //测试计划id，这里的编号要用服务器返回的来的数据编号
					var tr = '<tr class="bg-warning">' +
						'<td>2018-01-19</td>' +
						'<td>' + title + '</td>' +
						'<td data-id="' + test_id + '">' +
						'<button class="btn btn-xs btn-default btn-plan-del" title="\u5220\u9664">\r\n' +
						'<div class="text-danger">\r\n' +
						'<span class="glyphicon glyphicon-remove"></span>\r\n' +
						'<span class="hidden-xs">\u5220\u9664</span>\r\n' +
						'</div>\r\n</button>\r\n' +
						'</td></tr>';
					$('#modal-plan table[data-name="plan"]>tbody').append(tr);
					buildTipPopover($('#modal-plan .btn-plan-del'), id);

					$title.focus().val('');

					event.preventDefault();
					return false;
				});
			//});
		});

	//执行计划对话框(模式与制定计划对话框相似)
	$('#modal-plan-exec').on('show.bs.modal', function() {
			$load_layer_plan_exec.show(); //显示“正在加载数据...”层
			$data_layer_plan_exec.hide(); //隐藏数据层
		})
		.on('shown.bs.modal', function(e) {
			//要操作的销售机会id
			var id = $(e.relatedTarget).parent().data('id');

			//参考查看对话框中的操作
			//要注意：已执行的计划不显示执行按钮，只有未执行的计划才会显示执行按钮
			//$.getJSON('../../data/test.json', function(data) {
				$load_layer_plan_exec.slideUp('fast'); //隐藏“正在加载数据...”层
				$data_layer_plan_exec.slideDown('fast'); //显示数据内容层

				//设置显示数据及循环添加计划数据....

				$('#modal-plan-exec .btn-plan-exec').unbind().on('click', function() {
					//计划id
					var $resultTd = $(this).parents('td').first();
					var $timeTd = $resultTd.prev('td');
					var $time = $timeTd.find('input');
					var id = $resultTd.data('id');
					//执行结果
					var value = $(this).parent().prev().val();
					//执行时间
					var time = $time.val();

					//访问服务器更新计划信息....

					/*$.post('服务器更新计划的Action地址',{'id':id,'value':value},function(data){
						if(data.success){
							//操作成功，修改界面
						}else{
							//操作失败，给出提示
						}
					});*/
					//以下为修改界面演示版本
					$resultTd.children().slideUp('fast', function() {
						$resultTd.removeClass();
						$resultTd.append(value?value:'无结果');
						$resultTd.removeClass().addClass('text-primary');
						$resultTd.parent().removeClass();
					});
					$timeTd.children().slideUp('fast', function() {
						$timeTd.append(time);
						$timeTd.removeClass().addClass('text-primary');
						$timeTd.parent().removeClass();
					});
				});
			//});
		});

	//“开发完成”按钮单击事件
	$('.exec-complete').tipPopover({
		'placement': 'top',
		'content': function() {
			var _this = this;
			var buttons = $.parseHTML('<div><button class="btn btn-success"><span class="glyphicon glyphicon-ok"></span> ' +
				'<span class="hidden-xs">\u6210\u529F\uFF1F</span>' + '</button> ' +
				'<button class="btn btn-danger"><span class="glyphicon glyphicon-remove"></span> ' +
				'<span class="hidden-xs">\u5931\u8D25\uFF1F</span></button></div>');

			$(buttons).find('button:first').on('click', function() {
				exec_complete_success(_this);
			});
			$(buttons).find('button:last').on('click', function() {
				exec_complete_fail(_this);
			});

			return buttons;
		}
	});
});

function exec_complete_success(e) {
	var $btn_group = $(e).parent();
	var id = $btn_group.data('id');
	var $td = $btn_group.parent().prev();

	while($btn_group.children().length > 1)
		$btn_group.children().last().remove();

	$td.html($.parseHTML('<div class="text-success">' +
		'<span class="glyphicon glyphicon-ok" title="\u6210\u529F"></span>' +
		'<span class="hidden-xs">\u6210\u529F</span>' +
		'</div>'));
}

function exec_complete_fail(e) {
	var $btn_group = $(e).parent();
	var id = $btn_group.data('id');
	var $td = $btn_group.parent().prev();

	while($btn_group.children().length > 1)
		$btn_group.children().last().remove();

	$td.html($.parseHTML('<div class="text-danger">' +
		'<span class="glyphicon glyphicon-remove" title="\u5931\u8D25"></span>' +
		'<span class="hidden-xs">\u5931\u8D25</span>' +
		'</div>'));
}

function del_plan(e) {
	var id = $(e).parent().data('id');
	$(e).parents('tr').slideUp(200, function() {
		$(this).remove();
	});
}