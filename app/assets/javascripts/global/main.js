$(onLoad)
document.addEventListener("page:load", onLoad);

function onLoad() {
	$('#messages').children().each(function(i, o) {
		if($(o).html()) {
			flash_messages();
			return false
		}
	})
}

var flashing = false;

function flash_messages() {
	if(flashing) return
	flashing = true;
	var showHeight = $('#alert').height() + $('#notice').height()

	lines = (showHeight / parseInt($('#messages').css('line-height'))) || 1

	$('#messages') .
		css('height', showHeight+'px') .
		delay(1500*lines) .
		queue(function() {
			$('#messages').css('height','0');
			flashing = false;
		})
}