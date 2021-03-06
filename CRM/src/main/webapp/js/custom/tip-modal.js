/* *
 * 应用在 /html/index.html页面
 * 用来显示一个提示框
 * encoding:utf-8
 * */

var ModalTip = function(title, content, success) {
	this.interval = 0;
	this.dialog = null;
	this.id = 'modal-tip-div-' + (~~(Math.random()*1000000));
	this.template = '<div class="modal fade ' +
		(success ? 'text-success' : 'text-danger') +
		'" id="' + this.id + '">' +
		'<div class="modal-dialog modal-sm">' +
		'<div class="modal-content">' +
		'<div class="modal-header text-center">' +
		'<div class="modal-title">' +
		'<button class="close" data-dismiss="modal">&times;</button>' +
		title +
		'</div>' +
		'</div>' +
		'<div class="modal-body text-center h4">' +
		content +
		'</div>' +
		'<div class="modal-footer">' +
		'<button class="btn btn-sm ' +
		(success ? 'btn-success' : 'btn-danger') + '" data-dismiss="modal">\u5173\u95ED</button>' +
		'</div>' +
		'</div>' +
		'</div>' +
		'</div>';
	this.modal = function() {
		var this_ = this;
		if($('#' + this.id).length == 0) {
			$(document.body).append(this.template);
			$('#' + this.id)
				.on('shown.bs.modal', function() {
					this_.defaultButton().focus();
				}).on('hidden.bs.modal', function() {
					this_.destroy();
				});
		}
		this.modal_ = $('#' + this.id);
		return this;
	};
	this.destroy = function() {
		clearTimeout(this.interval);
		var modals = $('#' + this.id);
		if(modals.length != 0) {
			modals.remove();
		}
	};
	
	this.show = function(timeout) {
		var modal = this.modal();
		if(!isNaN(timeout)) {
			this.defaultButton('\u5173\u95ED(' + timeout + ')');
			var t = timeout;
			this.interval = setInterval(function() {
				t--;
				modal.defaultButton('\u5173\u95ED(' + t + ')');
				if(t <= 0) {
					clearInterval(modal.interval);
					modal.modal_.modal('hide');
				}
			}, 1000);
		}
		this.modal_.modal('show');
	};
	this.footer = function() {
		this.modal();
		return $('#' + this.id).find('.modal-footer');
	};
	this.defaultButton = function(text) {
		this.modal();
		var btn = $('#' + this.id).find('.modal-footer>.btn').first();
		if(text) {
			btn.text(text);
		}
		return btn;
	};
};

/**
 * 描述信息
 * */
function showTipSuccess(title, content) {
	if(!title)
		title = '\u63D0\u793A';
	if(!content)
		content = '\u64CD\u4F5C\u5B8C\u6210\u3002';
	new ModalTip(title, content, true).show(3);
}

function showTipFail(title, content) {
	if(!title)
		title = '\u63D0\u793A';
	if(!content)
		content = '\u64CD\u4F5C\u5931\u8D25\uFF01';
	new ModalTip(title, content).show(3);
}