(function($) {
	$.fn.extend({
		'tipPopover': function(option) {
			var Tip = function(element, options) {

				$(element).popover(options)
			}
			Tip.DEFAULTS = {
				'html': true,
				'container': 'body',
				'placement': 'bottom',
				'trigger': 'click|focus',
				'title': '\u63D0\u793A',
				'content': '<button class="btn btn-primary">\u786E\u5B9A\uFF1F</button>'
			}
			Tip.prototype.show = function(e) {
				$(e).popover('show')
			}
			Tip.prototype.hide = function(e) {
				$(e).popover('hide')
			}
			Tip.prototype.toggle = function(e) {
				$(e).popover('toggle')
			}
			Tip.prototype.destroy = function(e) {
				$(e).popover('destroy')
			}

			return this.each(function() {
				var data = $(this).data('gxm.popover')
				var options = $.extend({}, Tip.DEFAULTS, $(this).data(), typeof option == 'object' && option)
				if(!data) {
					$(this).data('gxm.popover', (data = new Tip(this, options)))
				}

				if(typeof option == 'string') {
					data[option](this)
				} else if(options.show) {
					data.show(this)
				}
			})
		}
	})
})(jQuery)