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

	//分配按钮
	$('.service-option').tipPopover({
		'placement': 'left',
		'trigger': 'click|focus',
		'content': function() {
			var _this = this;
			if(userItems == null) {
				return '<div class="h4 text-muted">数据加载中...</div>';
			} else if(!userItems.length) {
				return '<div class="h4 text-danger">暂无可用数据</div>';
			} else {
				var $links = $('<div class="list-group"></div>');
				$(userItems).map(function() {
					$links.append('<a href="#" class="list-group-item">' + this.name + '</a>');
				});

				$links.find('a').click(function() {
					var $div = $(_this).parents('tr:first').find('td:nth-child(4)>div');
					var name = $(this).text();
					$div.slideUp('fast', function() {
						var dt = new Date();
						var y = dt.getFullYear() + '/' + (dt.getMonth() + 1) + '/' + dt.getDate();
						var d = dt.getHours() + ':' + dt.getMinutes() + ':' + dt.getSeconds();
						$(this).html(name +
								'<div class="visible-xs"></div>[' +
								y +
								' <div class="visible-xs"></div>' +
								d + ']')
							.removeClass()
							.addClass('text-success')
							.slideDown('fast');
						$(_this).addClass('disabled').unbind(); //.hide('fast');
					});
					event.preventDefault();
				});

				return $links;
			}
		}
	});

	$('#form-add-exec').submit(function() {
		var $e1 = $('#form-add-exec textarea:first');
		var $e2 = $('#form-add-exec textarea:last');
		var $e3 = $('#form-add-exec select:first');

		var dt = new Date();
		var y = dt.getFullYear() + '/' + (dt.getMonth() + 1) + '/' + dt.getDate();
		var d = dt.getHours() + ':' + dt.getMinutes() + ':' + dt.getSeconds();
		var c = '';
		var s = '-';
		var e3v = parseInt($e3.val());
		for(var i = 0; i < e3v; i++) {
			s += '&#x2605;';
		}
		switch(e3v) {
			case 5:
				c = 'text-success';
				break;
			case 4:
				c = 'text-info';
				break;
			case 3:
				c = 'text-warning';
				break;
			case 2:
			case 1:
				c = 'text-danger';
				break;
		}

		var $tr = $('<tr class="bg-warning">' +
			'<td>' + y + ' <div class="visible-xs"></div>' + d + '</td>' +
			'<td>' + $e1.val() + '</td>' + '<td>' + $e2.val() + '</td>' +
			'<td>' + '<div class="' + c + '">' + s + '</div>' + '</td>' + '</tr>');
		$('#modal-exec .table-exec tbody tr').removeClass();
		$('#modal-exec .table-exec tbody').prepend($tr);

		$('#modal-exec .table-exec').collapse('show');

		event.preventDefault();

		this.reset();
	});

	//归档按钮
	$('.service-dic').tipPopover({
		'placement': 'top',
		'trigger': 'click|focus',
		'content': function() {
			var _this = this;
			var button = $('<button class="btn btn-primary">\u5F52\u6863</botton>');
			button.click(function() {
				$(_this).parents('tr:first').hide('slow', function() {
					$(this).remove();
					window.top.showTipSuccess();
				});
			});
			return button;
		}
	});

	//归档按钮
	$('.service-del').tipPopover({
		'placement': 'top',
		'trigger': 'click|focus',
		'content': function() {
			var _this = this;
			var button = $('<button class="btn btn-danger">\u5220\u9664\uFF1F</botton>');
			button.click(function() {
				$(_this).parents('tr:first').hide('slow', function() {
					$(this).remove();
					window.top.showTipSuccess();
				});
			});
			return button;
		}
	});
});