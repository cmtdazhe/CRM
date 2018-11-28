$(function() {
	$('ul.dropdown-menu a').click(function() {
		$('.dropdown.active').removeClass('active');
		$(this).parents('.dropdown').addClass('active');

		$('.dropdown-menu li.active').removeClass('active');
		$(this).parent('li').addClass('active');
	});

	$(window).resize(function() {
		var height = $('.bottom-navbar').offset().top -
			$('iframe').offset().top - 24;
		$('iframe').attr('height', height);
	}).resize();

});