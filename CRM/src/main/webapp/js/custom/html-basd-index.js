$(function() {
	buildPopover($('.basd-del'));

	$('#modal-type-add').on('hidden.bs.modal',function(){
		if('-1' == $('#cc2').val()){
			$('#cc2').val($('#cc2').find('option:first').val());
		}
		$('#modal-add').modal('toggle');
	});
	$('#form-type-add').submit(function() {
		$('#cc2 option[value="-1"]').before('<option selected="selected">' + $('#cc3').val() + '</option>');
		$('#modal-type-add').modal('toggle');
		this.reset();
		event.preventDefault();
	});

	$('#form-add').submit(function() {
		var id = (~~(Math.random() * 1000));
		var editable = $('#cc1').is(':checked');
		var type = $('#cc2').val();
		var title = $('#cc4').val();
		var value = $('#cc5').val();
		var option = (!editable ?
			'<td class="text-danger"><span class="glyphicon glyphicon-ban-circle"></span>' +
			'<span class="hidden-xs">\u4E0D\u53EF\u64CD\u4F5C</span></td>' :
			'<td><div class="btn-group btn-group-xs">' +
			'<button class="btn btn-default basd-edit">' +
			'<span class="glyphicon glyphicon-edit"></span>' +
			'<span class="hidden-xs">\u7F16\u8F91</span></button>' +
			'<button class="btn btn-default basd-del" title="\u5220\u9664">' +
			'<div class="text-danger">' +
			'<span class="glyphicon glyphicon-remove"></span>' +
			'<span class="hidden-xs">\u5220\u9664</span>' +
			'</div></button></div></td>');
		$('.table-data tbody tr').removeClass();
		$('.table-data tbody').prepend('<tr class="bg-warning"><td>' + id + '</td>' +
			'<td>' + type + '</td>' + '<td>' + title + '</td>' +
			'<td>' + value + '</td>' + option + '</tr>');

		buildPopover($('.table-data tbody tr:first .basd-del'));
		$('#modal-add').modal('toggle');
		this.reset();
		event.preventDefault();
	});

	$('#cc2').change(function() {
		if('-1' == this.value) {
			$('#modal-add').modal('toggle');
			$('#modal-type-add').modal('toggle');
		}
	});

	$('#form-edit').submit(function() {
		window.top.showTipSuccess();
	});
});

function buildPopover(e) {
	$(e).tipPopover({
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
}