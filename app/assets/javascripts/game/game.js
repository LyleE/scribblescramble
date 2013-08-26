var mouseDown = false, canvas, ctx, $cover, $timer, intervalID, isArtTime, endOfArtTime;

$(function() {
	$cover = $('#cover');
	$timer = $('#timer');
	canvas = document.getElementById('canvas');
  	if (canvas.getContext) {
	    ctx = canvas.getContext('2d');
	    var $canvas = $(canvas);
	    
	    $canvas.mousedown(mouseDownHandler);
	    $canvas.mousemove(mouseMoveHandler);
	    $canvas.mouseup(mouseUpHandler);
	    $canvas.mouseleave(mouseLeaveHandler);
	    $canvas.mouseenter(mouseEnterHandler);

	    $('.colour').click(colourClickHandler);
	    $cover.click(clickedStartHandler);

	    $(document).keypress(colourKeyDownHandler);
  	}
});

function mouseDownHandler(evt) {
	if(isArtTime) {
		mouseDown = true;
		ctx.beginPath();
		ctx.moveTo(evt.offsetX, evt.offsetY);
	}    
}

function mouseMoveHandler(evt) {
	if(isArtTime && mouseDown) {
		var x = Math.max(evt.offsetX, 0);
		var y = Math.max(evt.offsetY, 0);
		ctx.lineTo(x, y);
		ctx.stroke();
	}
}

function mouseUpHandler(evt) {
	if(isArtTime) {
		mouseDown = false;
		ctx.closePath();
	}
}

function mouseLeaveHandler(evt) {
	if(isArtTime) {
		mouseMoveHandler(evt);
		mouseUpHandler(evt);
	}
}

function mouseEnterHandler(evt) {
	if(isArtTime && evt.which) {
		mouseDownHandler(evt);
	}
}

function colourClickHandler(evt) {
	setColourTo($(evt.target).css('background-color'));
}

function colourKeyDownHandler(evt) {
	if(evt.which >= 48 && evt.which <58) { // numbers 0-9
		var key = evt.which - 48
		setColourTo($('.colour'+key).css('background-color'))
	}
}

function setColourTo(c) {
	console.log("set colour to:", c);
	ctx.strokeStyle = c;
	
}

function clickedStartHandler() {
	$cover.unbind('click');
	hideNotifications();
	countDownTo(startArt)
}

function startArt() {
	endOfArtTime = (new Date).getTime() + 10000
	isArtTime = true
	intervalID = setInterval(tick, 1000/60)
}

function tick() {
	timeLeft = endOfArtTime - (new Date).getTime()
	if(timeLeft > 0) {
		displayTimeLeft(timeLeft)
	} else {
		stopArt()
	}
}

function displayTimeLeft(time) {
	time /= 100; //tenths of a second
	time = parseInt(time);
	time /= 10; //seconds to 1dp
	time = new String(time)

	if(time.length == 1)
		time += ".0"

	$timer.html(time)
}

function stopArt() {
	isArtTime = false;
	displayTimeLeft(0)
	clearInterval(intervalID);
	$cover.show().html("Stop!")
	save();
}

function save() {
	$('#submit').submit();
}

//Called just before the form gets submitted
function setImageData() {
	var data=canvas.toDataURL("image/png");
	data = data.replace(/^data:image\/png;base64,/, "");   

	$('input#data').val(data)

	return true;
}

function countDownTo(callMe) {
   	queueMsg('Ready', 333);
   	queueMsg('Ready.', 333);
   	queueMsg('Ready..', 333);
   	queueMsg('Ready...', 333);
   	queueMsg('Scribble!', 333);
   	$cover.queue(function(next) {
   		$cover.css('opacity','0');
   		next();
   	}).
   	delay(300).
   	queue(function(next) {
   		$cover.hide();
   		callMe();
   		next();
   	});
}

function queueMsg(msg, time) {
	$cover.queue(function(next) {
		$cover.html(msg);
		next();
	}).delay(time);
}

function hideNotifications() {
	$('#messages').
		clearQueue().
		css('height','0');
}