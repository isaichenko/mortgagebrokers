jQuery(function($){

	$('.header_box .label').click(function() {

		$(this).toggleClass('active');

		$('.header_box .select').slideToggle(300, function() {
			if (this.style.display === 'none') {
				$(this).removeAttr('style');
			}
		});

	});

	$('.header_box .menu_btn').click(function() {

		$(this).toggleClass('close');

		$('.header_box .navigation').slideToggle(300, function() {
			if (this.style.display === 'none') {
				$(this).removeAttr('style');
			}
		});

	});

	$('.header_box .user_pic').click(function() {

		$(this).siblings('.user_menu').slideToggle(300, function() {
			if (this.style.display === 'none') {
				$(this).removeAttr('style');
			}
		});

	});

	$('.details_box .text_more').click(function() {

		$(this).hide().parents('.text').find('.text_hidden').show();

	});

	$('.text_mobile .more').click(function() {

		$(this).parents('.text_mobile').hide().siblings('.text_desktop').show();

	});

	$('.help_box .help_close').click(function() {

		$(this).parents('.help_box').removeClass('visible').fadeOut();

	});

});


/* Add review modal */

jQuery(function($){

	$('.modal_review').each(function() {

		$('.stars', this).each(function() {

			var element = $(this), rating = parseInt($('span.active', element).length);

			$('span', element).each(function(i) {

				var num = i + 1;

				$(this).click(function() {

					rating = num;

				});

				$(this).on('mouseover', function() {
					$('span', element).removeClass('active');
					$('span:lt(' + num + ')', element).addClass('active');
				});

			});

			element.on('mouseout', function() {
				$('span', element).removeClass('active');
				$('span:lt(' + rating + ')', element).addClass('active');
			});

		});

		$('[data-max]', this).each(function() {

			$(this).on('keydown keyup', function() {

				var field = $(this), maxlength = field.data('max'), counter = field.parents('.item').find('.counter');

				if ($.isNumeric(maxlength)) {
					field.val(field.val().substr(0, maxlength));
					counter.text(field.val().length + ' / ' + maxlength);
				}

			});

		});

	});

});


/* Scroll to top */

jQuery(function($){

	$('.pagination_box .top').click(function() {

		$('html, body').animate({
			scrollTop: 0
		}, 1000);

	});

});


/* Expand filters */

jQuery(function($){

	$('.find_box').each(function() {

		var wrapper = $(this);

		$('.expand', this).click(function() {

			var button = $(this);

			if (button.text() === 'Expand') {
				button.text('Collapse');
			} else {
				button.text('Expand');
			}

			wrapper.toggleClass('find_expandable');

			$('.expanded, .collapsed').slideToggle();

		});

	});

});


/* Tabs */

jQuery(function($){

	$('[data-tab-id]').click(function() {

		var id = $(this).data('tab-id');

		$(this).addClass('active').siblings().removeClass('active');

		if (id) {

			var ids = id.split(' ');

			var items = $('[data-tab]');

			items.each(function() {

				var tab = $(this).data('tab');

				if (tab && ids) {

					var tabs = tab.split(' ');

					var found = false;

					for (var i = 0; i < ids.length; i++) {

						if (tabs.indexOf(ids[i]) !== -1) {
							found = true;
							break;
						}

					}

					if (found) {
						$(this).show();
					} else {
						$(this).hide();
					}

				}

			});

		}

	});

});


/* Slider on the my balance page */

jQuery(function($){

	if (typeof noUiSlider !== 'undefined') {

		/* Number slider on balance page */

		(function() {

			var tickets_slider = document.getElementById('tickets_slider');

			if (tickets_slider) {

				noUiSlider.create(tickets_slider, {
					start: [50],
					connect: [true, false],
					range: {
						'min': [1],
						'max': [100]
					},
					step: 1
				});

				tickets_slider.noUiSlider.on('update', function(values, handle) {
					$('.tickets_box .number').text(parseInt(values[handle]));
				});

			}

		})();

		/* Score slider on request page */

		(function() {

			var request_slider = document.getElementById('request_slider');

			var request_range = {
				'min': [300],
				'32.5%': [500],
				'45%': [575],
				'57.5%': [650],
				'74.5%': [750],
				'max': [900]
			};

			var labels = [
				'Very poor',
				'Poor',
				'Fair',
				'Good',
				'Excellent',
				''
			];

			if (request_slider) {

				noUiSlider.create(request_slider, {
					range: request_range,
					start: [700],
					connect: [true, false],
					step: 5
				});

				request_slider.noUiSlider.on('update', function(values, handle) {
					$('.field_slider .number').text(parseInt(values[handle]));
				});

				var bars = $(request_slider).siblings('.bars');

				var style = '';

				var i = 1;

				for (var key in request_range) {

					if (key === 'min') {
						style = ' style="left: 0%"';
					} else if (key === 'max') {
						style = ' style="left: 100%"';
					} else {
						style = ' style="left: ' + key + '"';
					}

					bars.append('<div class="bar bar_' + i + '"' + style + '><span class="status">' + labels[i-1] + '</span><span class="pip">' + request_range[key][0] + '</span></div>');

					i++;

				}

			}

		})();

	}

});


/* FAQ block on the front page */

jQuery(function($){

	$('.faq_box').each(function() {

		$('.title', this).click(function() {

			var item = $(this).parents('.item');

			item.toggleClass('active').find('.text').slideToggle();

			item.siblings().removeClass('active').find('.text').slideUp();

		});

	});

});


/* Modal windows */

jQuery(function($){


	/* Basic scripts for modal windows */

	$('.modal_box .modal').click(function(e) {
		e.stopPropagation();
	});

	$('.modal_box, .modal_box .close, .modal_box .close_btn').click(function() {
		$('.modal_box').removeClass('is_visible');
	});

	$(document).keyup(function(e) {
		if (e.which === 27) {
			$('.modal_box').removeClass('is_visible');
		}
	});


	/* Show modal windows */

	$('[data-modal]').click(function() {

		var id = $(this).data('modal');

		if (id) {
			$('.modal_box').removeClass('is_visible');
			$('#modal_' + id).addClass('is_visible');
		}

	});

});


/* Sliders */

(function($){

	var $window = $(window), sliders;

	$window.on('load resize', function() {

		if (typeof $.fn.flickity !== 'undefined') {

			$('.proposals_box, .brokers_box').each(function() {

				var initialized = false, proposals = $(this).hasClass('proposals_box'), carousel = $('.items', this), items = $('.item', carousel), height = 0;

				if (($window.width() < 1024 || (items.length > 4 && proposals)) && !initialized) {

					carousel.flickity({
						wrapAround: true,
						prevNextButtons: false,
						pageDots: false,
						adaptiveHeight: false,
						cellSelector: '.item',
						imagesLoaded: true,
						cellAlign: 'left'
					});

					initialized = true;

				} else if (initialized) {

					carousel.flickity('destroy');

					initialized = false;

				}

				items.find('.card').css('min-height', 'auto').each(function() {
					height = Math.max(height, $(this).height());
				}).css('min-height', height);


			});

		}

	});

})(jQuery);


/* Select styling */

jQuery(function($) {

	if (typeof $.fn.styler !== 'undefined') {

		$('select').styler();

	}

});


/* Select languages */

jQuery(function($){

	$('.select_box').each(function() {

		var list = $('.select_list', this), inputs = $('input:radio, input:checkbox', this), field = $('.select_label', this);

		field.click(function() {

			field.toggleClass('active');

			list.toggle();

			list.parents('.item').css('z-index', 15);

		});

		$(this).click(function(e) {
			e.stopPropagation();
		});

		$('#site').click(function() {
			field.removeClass('active');
			list.hide().parents('.item').removeAttr('style');
		});

		$(document).keyup(function(e) {
			if (e.which === 27) {
				$('.modal_box').removeClass('is_visible');
			}
		});

		inputs.click(function() {

			field.html('');

			inputs.each(function() {

				var input = $(this), line = input.parents('li'), flag = $('.flag', line).clone();

				if (input.prop('checked')) {
					field.append(flag);
				}

			});

		});

	});

});


/* Pinned sidebar */

jQuery(window).on('load resize', function() {

	var $ = jQuery;

	$('.sidebar_pinned').each(function() {

		var wrapper = $(this), sidebar = $('.sidebar_box', wrapper), height = 0;

		if (sidebar.length > 0) {

			wrapper.removeClass('sidebar_pinned').removeAttr('style');

			height = sidebar.height() + wrapper.offset().top + 40;

			if (height < $(window).height()) {
				wrapper.css('min-height', height);
				wrapper.addClass('sidebar_pinned');
			}
		}

	});

});


/* Post a request page */

jQuery(function($) {

	var blocks = $('.fields_box .contents').parents('.fields');

	blocks.each(function() {

		var block = $(this),
			next = block.next().find('.contents'),
			fields = $('[type="text"], [type="tel"], [type="password"], [type="email"], select', block).not('.field_optional'),
			switches = $('input[type="radio"], input[type="checkbox"], .field_slider', block);

		fields.filter(':gt(0)').attr('disabled', true).trigger('refresh');

		fields.each(function(i) {

			var field = $(this), index = i + 1;

			field.on('change', function() {

				if (field.val() && index < fields.length) {
					$(fields[index]).attr('disabled', false).trigger('refresh');
				}

				if (index === fields.length) {
					next.slideDown();
				}

			});

		});

		switches.click(function() {
			next.slideDown();
		});

	});

});


/* Processing link */

jQuery(function($){

	$('[data-link]').click(function() {

		var link = $(this).data('link');

		if (link) {

			window.location.href = link;

		}

	});

});


/* Registration page */

jQuery(function($){

	$('.plan_featured .card_visible .button').click(function() {

		var wrapper = $(this).parents('.plans_box');

		wrapper.addClass('card_selected');

		resize();

	});

	$('.plan_featured').click(function(e) {

		e.stopPropagation();

	});

	$('.plans_box').click(function() {

		$(this).removeClass('card_selected').find('.plans').removeAttr('style');

	});

	$('#screen_2, #screen_3').hide();

	$('#screen_1 .btn_next').click(function() {
		$('.welcome_box .step:eq(1)').addClass('active');
		$('#screen_1').slideUp();
		$('#screen_2').slideDown();
	});

	$('#screen_2 .btn_next').click(function() {
		$('.welcome_box .step:eq(2)').addClass('active');
		$('#screen_2').slideUp();
		$('#screen_3').slideDown();
	});

	function resize() {

		$('.plans_box.card_selected').each(function() {

			var wrapper = $(this), plans = $('.plans', wrapper);

			plans.css('min-height', '0');

			var height = $('.card_hidden', wrapper).height() + 80;

			plans.css('min-height', height);

		});

	}

	$(window).on('resize', resize);

});


/* Swipe plans on registration page */

(function($) {

	var $window = $(window);

	$('.plans_box').each(function() {

		var plans = $(this),
			slider = $('.plans', this),
			featured = $('.plan_featured'),
			card = $('.card_hidden', featured),
			initialized = false,
			offset = 0,
			margin;

		$(window).on('load resize', function() {

			if ($window.width() < 560) {

				if (!initialized) {
					document.addEventListener('touchstart', handleTouchStart, false);
					document.addEventListener('touchmove', handleTouchMove, false);
					initialized = true;
				}

			} else {

				if (initialized) {
					document.removeEventListener('touchstart', handleTouchStart);
					document.removeEventListener('touchmove', handleTouchMove);
					initialized = false;
					card.removeAttr('style');
					slider.removeAttr('style');
				}

			}

		});

		var xDown = null;
		var yDown = null;

		function getTouches(event) {
			return event.touches || event.originalEvent.touches;
		}

		function handleTouchStart(event) {
			xDown = getTouches(event)[0].clientX;
			yDown = getTouches(event)[0].clientY;
		}

		function handleTouchMove(event) {

			if (!xDown || !yDown) {
				return;
			}

			var xUp = event.touches[0].clientX;
			var yUp = event.touches[0].clientY;

			var xDiff = xDown - xUp;
			var yDiff = yDown - yUp;

			offset = 0;

			margin = -parseInt(featured.width() / 2);

			if (Math.abs(xDiff) > Math.abs(yDiff) && !(plans.hasClass('card_selected'))) {

				if (xDiff > 0) {
					offset = -parseInt(featured.width() - parseInt($window.width() - featured.offset().left) / 2);
				}

				card.css('margin-left', margin - offset);

				slider.css('left', offset);

			} else {

				return;

			}

			xDown = null;
			yDown = null;

		}

	});

})(jQuery);


/* Upload a file */

jQuery(function($){

	$('.fields_box .field_file').each(function() {

		var input = $('input:file', this), label = $('label', this), text = $('.upload_files', this);

		input.on('change', function() {
			label.addClass('uploaded');
			text.find('b').text($(this).val().replace("C:\\fakepath\\", ""));
			text.hide().fadeIn();
		});

		$('.close', this).on('click', function() {
			label.removeClass('uploaded');
			input.val('');
			text.fadeOut(300, function() {
				text.find('b').text('');
			});
		});

	});

});