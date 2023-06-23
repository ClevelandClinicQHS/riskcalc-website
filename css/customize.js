var amountScrolled = 50;

$(window).scroll(function() {
	if ( $(window).scrollTop() > amountScrolled ) {
		$('a.back-to-top').fadeIn('normal');
	} else {
		$('a.back-to-top').fadeOut('normal');
	}
});


$('a.back-to-top').click(function() {
	$('html, body').animate({
		scrollTop: 0
	}, 600);
	return false;
});

$('a[href*="#"]:not([href="#"])').click(function() {
  if (location.pathname.replace(/^\//, '') == this.pathname.replace(/^\//, '') && location.hostname == this.hostname) {
    var target = $(this.hash);
    target = target.length ? target : $('[name=' + this.hash.slice(1) + ']');
    if (target.length) {
      $('html, body').animate({
        scrollTop: target.offset().top - 100
      }, 600);
      return false;
    }
  }
});

$(".dropdown-menu a").click(function() {
    $(this).closest(".dropdown-menu").prev().dropdown("toggle");
});

// function bringToFront(dropdown) {
//     setTimeout(
//         function () {dropdown.find('.dropdown-menu').css({ 'top': dropdown.offset().top + dropdown.outerHeight() - $(window).scrollTop(), 'left': dropdown.offset().left - $(window).scrollLeft(), 'position': 'fixed' })
//     }, 1)
// }

// $('.navbar .dropdown').on('shown.bs.dropdown', function () { bringToFront($(this)); });
