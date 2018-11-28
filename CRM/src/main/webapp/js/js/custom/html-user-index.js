$(function() {
	$('.refresh-password').click(function() {
		top.showTipSuccess();
		$('#modal-edit').modal('toggle');
	});
	$('.data-table tbody .btn-group-xs button:nth-child(2)').click(function() {
		window.top.showTipSuccess();
		window.location.reload();
	});
	$('.data-table tbody .btn-group-xs button:last-child').tipPopover({
		'placement': 'top',
		'content': function() {
			var this_ = this;
			var $button = $('<button class="btn btn-danger">删除</button>');
			$button.click(function() {
				$(this_).parents('tr:first').hide('slow', function() {
					$(this).remove();
				});
			});
			return $button;
		}
	});
});