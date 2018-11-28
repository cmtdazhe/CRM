$(function() {
	$('.lost-option').tipPopover({
		'placement': 'top',
		'trigger': 'click|focus',
		'content': function() {
			var _this = this;
			$tr = $(_this).parents('tr:first');
			$state_div = $tr.find('td:nth-child(5)>div');
			var buttons = $('<div class="btn-group btn-group-sm text-nowrap">' +
				'<button class="btn btn-primary" title="\u6682\u7F13">' +
				'<span class="glyphicon glyphicon-time"></span>' +
				'<span class="hidden-xs">\u6682\u7F13</span>' +
				'</button>' +
				'<button class="btn btn-success" title="恢复客户">' +
				'<span class="glyphicon glyphicon-ok"></span>' +
				'<span class="hidden-xs">恢复</span>' +
				'</button>' +
				'<button class="btn btn-danger" title="流失客户">' +
				'<span class="glyphicon glyphicon-remove"></span>' +
				'<span class="hidden-xs">流失</span>' +
				'</button>' +
				'</div>');

			buttons.find('.btn').first().click(function() {
				$state_div.slideUp('fast', function() {
					$(this).html('<div class="text-success">\u6682\u7F13<div class="visible-xs"></div>[2018/02/18]</div>').slideDown('fast');
				});
			});
			buttons.find('.btn:nth-child(2)').click(function() {
				$tr.hide('slow', function() {
					$(this).remove();
					window.top.showTipSuccess(null, '\u5DF2\u6210\u529F\u6062\u590D\u5BA2\u6237\u4FE1\u606F\uFF01');
				});
			});
			buttons.find('.btn').last().click(function() {
				$('#modal-lost').modal('show');
				$('#form-lost').submit(function(){
					$('#modal-lost').modal('hide');
					var lost_dest = $('#form-lost input').val();
					this.reset();
					$state_div.slideUp('fast', function() {
						$(this).html('<div class="text-danger"> \u6D41\u5931 '+
							'<div class="visible-xs"></div>[2018/02/18] '+
							'<span class="text-muted hidden-xs">原因：'+lost_dest+'</span></div>').slideDown('fast');
					});
					$(_this).unbind().fadeOut('slow');
					return false;
				});
				
			});

			return buttons;
		}
	});
});