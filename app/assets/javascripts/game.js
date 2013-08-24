var mouseDown = false, canvas, ctx;

$(function() {
	canvas = document.getElementById('canvas');
  	if (canvas.getContext) {
	    ctx = canvas.getContext('2d');
	    var $canvas = $(canvas);
	    
	    $canvas.mousedown(mouseDownHandler);
	    $canvas.mousemove(mouseMoveHandler);
	    $canvas.mouseup(mouseUpHandler);
	    
	    $canvas.mouseleave(function(evt) {
	    	mouseMoveHandler(evt);
	    	mouseUpHandler(evt);
	    });
	    $canvas.mouseenter(function(evt) {
	    	if(evt.which)
	    		mouseDownHandler(evt);
	    });
  	}
});

function mouseDownHandler(evt) {
	mouseDown = true;
	    	
	ctx.beginPath();
	ctx.moveTo(evt.offsetX, evt.offsetY);    
}

function mouseMoveHandler(evt) {
	if(mouseDown) {
		var x = Math.max(evt.offsetX, 0);
		var y = Math.max(evt.offsetY, 0);
		ctx.lineTo(x, y);
		ctx.stroke();
	}
}

function mouseUpHandler(evt) {
	mouseDown = false;
	ctx.closePath();
}




