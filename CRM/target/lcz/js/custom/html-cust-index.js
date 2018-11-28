$(function() {
	$('#form-edit').submit(function() {
		window.top.showTipSuccess();

		//演示效果
		var $modal = $(this).parents('.modal');
		if(!!$modal.length) {
			$modal.modal('hide');
			window.location.reload();
		}
		event.preventDefault();
	});
	
	$('#form-add-linkman').submit(function(){
		window.top.showTipSuccess();
		var $modal = $(this).parents('.modal');
		if(!!$modal.length) {
			$modal.modal('hide');
		}
		event.preventDefault();
	});
	
	$('#form-edit-linkman').submit(function(){
		window.top.showTipSuccess();
		var $modal = $(this).parents('.modal');
		if(!!$modal.length) {
			$modal.modal('hide');
		}
		event.preventDefault();
	});
	
	$('#form-add-activity').submit(function(){
		window.top.showTipSuccess();
		var $modal = $(this).parents('.modal');
		if(!!$modal.length) {
			$modal.modal('hide');
		}
		event.preventDefault();
	});

	$('.modal .del-linkman').tipPopover({
		'placement': 'top',
		'trigger': 'click|focus',
		'content': function() {
			var _this = this;
			//组织将要显示的弹出框显示内容
			//从单击的按钮中得到data-id(联系人)编号
			var id = $(this).parent().data('id');

			var button = $('<button class="btn btn-danger">\u5220\u9664\uFF1F</button>');

			button.click(function() {
				$(_this).parents('tr').first().hide('fast', function() {
					$(this).remove();
				})
			});

			return button;
		}
	});

	$('.modal .del-activity').tipPopover({
		'placement': 'top',
		'trigger': 'click|focus',
		'content': function() {
			var _this = this;
			//组织将要显示的弹出框显示内容
			//从单击的按钮中得到data-id(联系人)编号
			var id = $(this).parent().data('id');

			var button = $('<button class="btn btn-danger">\u5220\u9664\uFF1F</button>');

			button.click(function() {
				$(_this).parents('tr').first().hide('fast', function() {
					$(this).remove();
				})
			});

			return button;
		}
	});
	
	$('.lost-cust').tipPopover({
		'placement': 'top',
		'trigger': 'click|focus',
		'content': function() {
			var _this = this;

			var button = $('<button class="btn btn-danger">\u786E\u5B9A\u6807\u8BB0\u4E3A\u201C\u6D41\u5931\u201D\uFF1F</button>');

			button.click(function() {
				$(_this).parents('tr').first().hide('slow', function() {
					$(this).remove();
				})
			});

			return button;
		}
	});
});