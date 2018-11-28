$(function() {
	$('table .btn-group button:nth-child(2)').click(function() {
		window.top.showTipSuccess();
		window.location.reload();
	});

	$('table .btn-group button:last-child').tipPopover({
		'placement': 'top',
		'trigger': 'click|focus',
		'content': function() {
			var _this = this;

			var button = $('<button class="btn btn-danger">\u5220\u9664\uFF1F</button>');

			button.click(function() {
				$(_this).parents('tr').first().hide('fast', function() {
					$(this).remove();
				})
			});

			return button;
		}
	});

	$('.panel-heading input[type="checkbox"]').change(function() {
		event.preventDefault();
		var chked = this.checked;
		var $panel = $(this).parents('.panel');
		var $body = $panel.find('.panel-body');
		$body.find('input[type="checkbox"]').each(function(){
			if(!$(this).prop('disabled')){
				this.checked = chked;
			}
		});
	});
	$('.panel-body input[type="checkbox"]').change(function() {
		event.preventDefault();
		var $body = $(this).parents('.panel-body');
		var hchk = $body.parents('.panel').find('.panel-heading input[type="checkbox"]')[0];
		var chk = true;
		$body.find('input[type="checkbox"]').each(function() {
			if(!this.checked) {
				chk = false;
				return;
			}
		});
		hchk.checked = chk;
	});
});