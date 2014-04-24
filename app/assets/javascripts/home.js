/* 
* @Author: george
* @Date:   2014-02-27 16:55:31
* @Last Modified by:   george
* @Last Modified time: 2014-03-24 21:54:32
*/

/**
 * YouTubePlayer
 * https://github.com/dmolsen/YoutubePlayer
 */
;(function(e){function n(e,t,r){this.id=e;this.videoId=t;this.handlers={};this.ref=null;this.width="425";this.height="356";this.flashVersion="8";this.chromeless=false;this.objparams={allowScriptAccess:"always"};this.ytparams={version:3};this.attrs={id:this.id};var i=function(e,t){for(var n in e){t[n]=e[n]}};if(r){if(r.objparams)i(r.objparams,this.objparams);if(r.ytparams)i(r.ytparams,this.ytparams);if(r.attrs)i(r.attrs,this.attrs);if(r.width)this.width=r.width;if(r.height)this.height=r.height;if(r.flashVersion)this.flashVersion=r.flashVersion;if(r.chromeless)this.chromeless=r.chromeless}this.embed();n.register(this)}var t="";n.prototype.embed=function(){var e="";for(val in this.ytparams){e+="&"+val+"="+this.ytparams[val]}if(this.chromeless){var t="http://www.youtube.com/apiplayer?video_id={videoId}&version=3&enablejsapi=1&playerapiid={playerId}"}else{var t="http://www.youtube.com/v/{videoId}?enablejsapi=1&playerapiid={playerId}{yturlparams}"}t=t.replace("{videoId}",this.videoId);t=t.replace("{playerId}",this.id);t=t.replace("{yturlparams}",e);if(!swfobject){throw new ReferenceError("YoutubePlayer depends on the SWFObject library but it is missing.")}var n=this;swfobject.embedSWF(t,this.id,this.width,this.height,this.flashVersion,null,null,this.objparams,this.attrs,function(e){n.ref=e.ref})};n.prototype.on=n.prototype.at=function(e,t,n){n=typeof n=="undefined"?500:n;if(e.indexOf("-")!=-1){eventNames=e.split("-");startTime=parseInt(eventNames[0]);endTime=parseInt(eventNames[1]);while(endTime>=startTime){this.handlers[startTime.toString()]=this.handlers[startTime.toString()]||[];this.handlers[startTime.toString()].push(t);startTime+=n}}else if(e.indexOf(",")!=-1){eventNames=e.split(",");for(var r in eventNames){this.handlers[eventNames[r]]=this.handlers[eventNames[r]]||[];this.handlers[eventNames[r]].push(t)}}else{this.handlers[e]=this.handlers[e]||[];this.handlers[e].push(t)}};n.prototype.onReady=function(){var e=document.getElementById(this.id);t=this.id;e.addEventListener("onStateChange","YoutubePlayer.dispatchEvent")};n.prototype.notifyEvent=function(e){var t=n.STATES;for(var r in t){if(t[r]==e){this.fireEvent(r)}}};n.prototype.fireEvent=function(e){var t=this.handlers[e];if(!t){return}for(var n=0;n<t.length;n++){t[n](e)}};n.instances=[];n.register=function(e){this.instances.push(e)};n.findById=function(e){var t=null;for(var n=0;n<this.instances.length;n++){if(this.instances[n].id==e){t=this.instances[n]}}return t};n.dispatchEvent=function(e){var r=n.findById(t);r.notifyEvent(e)};n.STATES={unstarted:-1,ended:0,playing:1,paused:2,buffering:3,cued:5};e.YoutubePlayer=n;e.onYouTubePlayerReady=function(e){n.findById(e).onReady()}})(window);

/**
 * Draw a radar like background
 */
(function( $ ){

	//
	// IVARS GLOBAIS
	//

	/** @var string Context name */
	var name;
	/** @var float First circle center in X (0.5 means middle) */
	var anchorPointX;
	/** @var float First circle center in Y (0.5 means middle) */
	var anchorPointY;
	/** @var int The initial radius */
	var initialRadius;
	/** @var int The radius increment */
	var radiusIncrement;
	/** @var boolean Jump the first circle drawing */
	var jumpFirstCircle;
	/** @var string The stroke color */
	var color;

	$.fn.radarBackground = function( method ) {
		
		// Default settings
		var settings = {
			// These are the defaults.
			name: "radar",
			anchorPointX: 0.5, // middle of the screen
			anchorPointY: 0.5, // middle of the screen
			initialRadius: 50,
			radiusIncrement: 50,
			jumpFirstCircle: false,
			color: 'black'
		};
		
		// Method calling logic
		if ( methods[method] ) {
			return methods[ method ].apply( this, Array.prototype.slice.call( arguments, 1 ));
		} else if (typeof(method)=='undefined') {
			return methods.init( settings );
		} else if ( typeof method === 'object' || ! method) {
			method = $.extend({}, settings, method);
			return methods.init.apply( this, arguments );
		} else {
			$.error( 'The method ' +  method + ' doesn\'t exit jQuery.radarBackground' );
		}    
  
	};

	//
	// PUBLIC METHODS
	//
	var methods = {
		init : function( options ) {
			
			// parametrizas variaveis internas
			name = options.name;
			anchorPointX = options.anchorPointX;
			anchorPointY = options.anchorPointY;
			initialRadius = options.initialRadius;
			radiusIncrement = options.radiusIncrement;
			jumpFirstCircle = options.jumpFirstCircle;
			color = options.color;

			// draw radar on context
			draw();
			
			// bind resize callback
			window.addEventListener('resize', draw, false);
			$(window).bind('resize', function(){
				// resize window
				draw();
			});
		},
		redraw : function() {
		   draw();
		}
	};

	//
	// PRIVATE METHODS
	//
	var draw = function(){
		var width = parseInt($(document).width());
		var height = parseInt($(document).height());

		var ctx = document.getCSSCanvasContext("2d", "squares", width, height);	
		var limitRadius = Math.max(width, height)/2.0;
		var currentRadius = initialRadius;

		while (currentRadius < limitRadius * 2.00) {
			
			// jump the first circule?
			if (jumpFirstCircle) {
				jumpFirstCircle = false;
				currentRadius += radiusIncrement;
				continue;
			}
			
			// Draw the circle
			ctx.beginPath();
			ctx.strokeStyle = color;
			ctx.arc((width * anchorPointX),
				(height * anchorPointY),
				currentRadius*2,0,2*Math.PI);
			ctx.stroke();

			currentRadius += radiusIncrement;
		}
	};

})( jQuery );

/**
 * Show video with actions
 */
(function( $ ){

	//
	// IVARS GLOBAIS
	//

	/** @var string The video ID on YouTube */
	var videoID;
	/** @var int Video width in pixels */
	var width;
	/** @var int Video height in pixels */
	var height;
	/** @var array Video params (check YouTube documentation) */
	var ytParams;
	/** @var array Cue points to execute function */
	var cueTimes;
	/** @var function Function to execute when firing the cue */
	var cueTimeCallBack;
	/** @var function Function to execute when video ended */
	var endedCallBack;
	/** @var function Function to execute when video restarts in loop */
	var replayCallback;

	/** @var object The video that holds the video. Youtube official API executes here */
	var videoPlaceHolder;

	/** @var object The YouTube video object */
	var YTVideo;
	/** @var bool Video is playing tag */
	var isPlaying;
	/** @var int Video total time */
	var videoTimeRaw;
	/** @var int Video current time */
	var currentTime;
	/** @var int Interval between video time readings */
	var defaultInterval;
	/** @var object Timer for checkint video time */
	var timeCheck;

	/** @var bool Flag for the window. Hidden or not */
	var hidden;
	/** @var bool Flag the video state before window loses focus */
	var videoStateBeforeFocusLoss;

	$.fn.videoAction = function( method ) {
		
		// Default settings
		var settings = {
			// These are the defaults.
			videoID: "",
			width: 640,
			height: 360,
			ytParams: { autoplay: 0, controls: 1, iv_load_policy:3, rel: 0, showsearch: 0, showinfo: 0, modestbranding: 0 },
			cueTimes: "",
			cueTimeCallBack: function(){},
			endedCallBack: function(){},
			replayCallback: function(){}
		};
		
		// Method calling logic
		if ( methods[method] ) {
			return methods[ method ].apply( this, Array.prototype.slice.call( arguments, 1 ));
		} else if (typeof(method)=='undefined') {
			return methods.init( settings );
		} else if ( typeof method === 'object' || ! method) {
			method = $.extend({}, settings, method);
			return methods.init.apply( this, arguments );
		} else {
			$.error( 'The method ' +  method + ' doesn\'t exit jQuery.videoAction' );
		}    
  
	};

	//
	// PUBLIC METHODS
	//
	var methods = {
		init : function( options ) {
			
			// parametrizas variaveis internas
			videoID = options.videoID;
			width = options.width;
			height = options.height;
			ytParams = options.ytParams;
			cueTimes = options.cueTimes;
			cueTimeCallBack = options.cueTimeCallBack;
			endedCallBack = options.endedCallBack;
			replayCallback = options.replayCallback;

			isPlaying = false;
			videoTimeRaw = 0;
			currentTime = 0;
			defaultInterval = 100;

			videoPlaceHolder = this.attr("id");
			videoStateBeforeFocusLoss = true;	// begins player

			// every 100ms do the following:
			//   - see if a video is playing. if it is:
			//      -- increment the currentTime tracker 100  
			//      -- fires an event that matches that currentTime
			timeCheck = setInterval(function() {
				if (isPlaying != false) {
					currentTime += defaultInterval;
					YTVideo.fireEvent(currentTime.toString());
				}
			}, defaultInterval);


			// init the video
			YTVideo = new YoutubePlayer($(this).attr("id"), videoID,{
				width: width,
				height: height,
				ytparams: ytParams,
				attrs:  { class: 'ytembed' }
			});

			// listen for the standard events and note that the video isnt playing
			YTVideo.on('unstarted,buffering,cued', function() {
				isPlaying = false;
				replayCallback();
			});

			YTVideo.on('paused', function() {
				isPlaying = false;
			});

			YTVideo.on('ended', function() {
				isPlaying = false;
				endedCallBack();
			});

			// listen for when the video is played. update the currentTime incrementor based on
			// where the user is in the video. note that the video IS playing.
			YTVideo.on('playing', function() {
				videoTimeRaw = document.getElementById(videoPlaceHolder).getCurrentTime();
				currentTime = Math.round(videoTimeRaw*10)*100;
				isPlaying = true;
			});

			// fire actions on cue times
			YTVideo.at(cueTimes, function() {
				cueTimeCallBack();
			});

			// Watches for window focus, but in the right way.
			hidden = "hidden";

		    // Standards:
		    if (hidden in document)
		        document.addEventListener("visibilitychange", onchange);
		    else if ((hidden = "mozHidden") in document)
		        document.addEventListener("mozvisibilitychange", onchange);
		    else if ((hidden = "webkitHidden") in document)
		        document.addEventListener("webkitvisibilitychange", onchange);
		    else if ((hidden = "msHidden") in document)
		        document.addEventListener("msvisibilitychange", onchange);
		    // IE 9 and lower:
		    else if ('onfocusin' in document)
		        document.onfocusin = document.onfocusout = onchange;
		    // All others:
		    else
		        window.onpageshow = window.onpagehide 
		            = window.onfocus = window.onblur = onchange;
		},
		videoObject : function() {
		   return YTVideo;
		},
		currentTime : function(){
			return currentTime;
		},
		videoPlaying : function(){
			return isPlaying;
		}
	};

	//
	// PRIVATE METHODS
	//
	
	/**
	 * Handler for the window focus callback
	 * @param  obj evt The event caller
	 * @return void
	 */
    function onchange (evt) {
        var v = 'visible', h = 'hidden',
            evtMap = { 
                focus:v, focusin:v, pageshow:v, blur:h, focusout:h, pagehide:h 
            };

        evt = evt || window.event;
        if (evt.type in evtMap)
            document.body.className = evtMap[evt.type];
        else{
        	if(this[hidden]){
        		// Window not active
        		videoStateBeforeFocusLoss = $().videoAction("videoPlaying");

        		if(videoStateBeforeFocusLoss){
        			document.getElementById(videoPlaceHolder).pauseVideo();
        		}
        	}
        	else{
        		// Window active
        		if (videoStateBeforeFocusLoss) {
        			document.getElementById(videoPlaceHolder).playVideo();
        		}
        	}
        }
    }

})( jQuery );

/**
 * Coordinate a collection of DIVs appearances
 */
(function( $ ){

	//
	// GLOBAL IVARS
	//

	/** @var array The array of elements to show */
	var elements;
	/** @var float The animation time in seconds */
	var animationTime;

	/** @var int The index of the current active element */
	var currentElementIndex;
	/** @var object Timer for the current element on screen */
	var timerForTTLOnScreen;

	$.fn.showHideCoordinator = function( method ) {
		
		// Default settings
		var settings = {
			// These are the defaults.
			elements: [],
			animationTime: 1.0
		};
		
		// Method calling logic
		if ( methods[method] ) {
			return methods[ method ].apply( this, Array.prototype.slice.call( arguments, 1 ));
		} else if (typeof(method)=='undefined') {
			return methods.init( settings );
		} else if ( typeof method === 'object' || ! method) {
			method = $.extend({}, settings, method);
			return methods.init.apply( this, arguments );
		} else {
			$.error( 'The method ' +  method + ' doesn\'t exit jQuery.showHideCoordinator' );
		}    
  
	};

	//
	// PUBLIC METHODS
	//
	var methods = {
		init : function( options ) {
			
			// parametrizes variaveis internas
			elements = options.elements;
			animationTime = options.animationTime * 1000;

			currentElementIndex = -1;
		},
		showNext : function() {
			hideElement(currentElementIndex);
			showElement(nextElementIndex());
		},
		hideCurrent : function(){
			hideElement(currentElementIndex);
		},
		hideAll : function(){
			hideAllElements();
		},
		reset : function(){

			// clear timers
			window.clearInterval(timerForTTLOnScreen);

			// reset index
			currentElementIndex = -1;

			// hide all elements (animated)
			hideAllElements();
		}
	};

	//
	// PRIVATE METHODS
	//

	var showElement = function(index){
		if (index >=0 && index < elements.length) {

			var elementToShow = elements[index].element;
			var elementTTL = elements[index].ttl;

			$(elementToShow).css({"opacity":0.0});
			$(elementToShow).css({"display":"block"});
			$(elementToShow).animate({"opacity":1.0}, animationTime, function(){
				// if last element, set a timer to hide, otherwise it will stay on
				// screen until the video ends
				if (elementTTL > 0) {
					timerForTTLOnScreen = setTimeout(function(){
						hideElement(index);
					}, elementTTL);
				}
			});
		}
	};

	var hideElement = function(index){
		if (index >=0 && index < elements.length) {
			var elementToHide = elements[index].element;
			$(elementToHide).animate({"opacity":0.0}, animationTime, function(){
				$(this).css({"display":"none"});
			});
		};
	};

	var nextElementIndex = function(){
		if (++currentElementIndex > elements.length) currentElementIndex = 0;
		return currentElementIndex;
	};

	var previousElementIndex = function(){
		var previousElementIndex = currentElementIndex - 1;
		if (previousElementIndex < 0) currentElementIndex = elements.length -1;
		return previousElementIndex;
	};

	var hideAllElements = function(){
		for(i=0; i<elements.length; i++){
			elements[i].element.animate({opacity:0.0}, animationTime, function(){
				$(this).css({"display":"none"});
			});
		}
	};

})( jQuery );

/**
 * Resize and reposition a element according to the current screen height
 */
(function( $ ){

	//
	// IVARS GLOBAIS
	//

	/** @var obj the element to apply the scale and position */
	var element;

	/** @var int max height */
	var maxH;
	/** @var int min height */
	var minH;
	/** @var float scale when at maxH */
	var maxS;
	/** @var float scale when at minH */
	var minS;
	/** @var float bottom when at maxH */
	var maxB;
	/** @var float bottom when at minH */
	var minB;

	$.fn.scaleAndPositionFromScreenHeight = function( method ) {
		
		// Default settings
		var settings = {
			// These are the defaults.
			maxHeight: 740,		// max height
			minHeight: 500,		// min height
			maxScale: 1.0,		// scale when at maxH
			minScale: 0.5,		// scale when at minH
			maxBottom: -1.0,	// bottom when at maxH
			minBottom: -130		// bottom when at minH
		};
		
		// Method calling logic
		if ( methods[method] ) {
			return methods[ method ].apply( this, Array.prototype.slice.call( arguments, 1 ));
		} else if (typeof(method)=='undefined') {
			return methods.init( settings );
		} else if ( typeof method === 'object' || ! method) {
			method = $.extend({}, settings, method);
			return methods.init.apply( this, arguments );
		} else {
			$.error( 'The method ' +  method + ' doesn\'t exit jQuery.scaleAndPositionFromScreenHeight' );
		}    
  
	};

	//
	// PUBLIC METHODS
	//
	var methods = {
		init : function( options ) {
			
			element = $(this);

			// parametrizas variaveis internas
			maxH = options.maxHeight;
			minH = options.minHeight;
			maxS = options.maxScale;
			minS = options.minScale;
			maxB = options.maxBottom;
			minB = options.minBottom;

			// draw radar on context
			scaleAndPosition(element);
			
			// bind resize callback
			$(window).bind('resize', function(){
				// resize window
				scaleAndPosition(element);
			});
		},
		recalculate : function() {
		   scaleAndPosition(element);
		}
	};

	//
	// PRIVATE METHODS
	//
	
	/**
	 * Resizes a given element according to the current screen height
	 * @param  obj element The element to resize
	 * @return void
	 */
	var scaleAndPosition = function(element){
		var height = $("html").height();

		// protect against height values
		if (height > maxH) height = maxH;
		if (height < minH) height = minH;

		// calculate scale and bottom new values
		var scale = (((height - minH) * (maxS - minS))/(maxH - minH))+minS;
		var bottom = (((height - minH) * (maxB - minB))/(maxH - minH))+minB;

		// apply values
		applyScaleToElement(scale, element);
		applyBottomToElement(bottom, element);
	};

	/**
	 * Apply a given scale to a given element
	 * @param  float scale 	The new scale to apply
	 * @param  obj element The element to resize
	 * @return void
	 */
	var applyScaleToElement = function(scale, element){

	    element.css({"transform":"scale("+scale+", "+scale+")"});
	    element.css({"-webkit-transform":"scale("+scale+", "+scale+")"});
	    element.css({"-moz-transform":"scale("+scale+", "+scale+")"});
	    element.css({"-o-transform":"scale("+scale+", "+scale+")"});
	    element.css({"-ms-transform":"scale("+scale+", "+scale+")"});
	};

	/**
	 * Apply a given bottom space to a given element
	 * @param  float scale 	The new bottom space to apply
	 * @param  obj element The element to apply the bottom space
	 * @return void
	 */
	var applyBottomToElement = function(bottom, element){
		element.css({"bottom":bottom+"px"});
	};

})( jQuery );

/**
 * Subscription view
 */
(function( $ ){

	//
	// IVARS GLOBAIS
	//

	/** @var obj the element to apply the scale and position */
	var element;
	/** @var obj the button that toggles the newsletter box on or off*/
	var toggleButton;
	/** @var the button to submit the form */
	var submitButton;
	/** @var obj On open callback */
	var onOpenCallback;
	/** @var obj On close callback */
	var onCloseCallback;

	$.fn.subscription = function( method ) {
		
		// Default settings
		var settings = {
			// These are the defaults.
			toggle: '',
			submit: '',
			onOpenCallback: function(){},
			onCloseCallback: function(){}
			
		};
		
		// Method calling logic
		if ( methods[method] ) {
			return methods[ method ].apply( this, Array.prototype.slice.call( arguments, 1 ));
		} else if (typeof(method)=='undefined') {
			return methods.init( settings );
		} else if ( typeof method === 'object' || ! method) {
			method = $.extend({}, settings, method);
			return methods.init.apply( this, arguments );
		} else {
			$.error( 'The method ' +  method + ' doesn\'t exit jQuery.subscription' );
		}    
  
	};

	//
	// PUBLIC METHODS
	//
	var methods = {
		init : function( options ) {
			
			element = $(this);
			toggleButton = options.toggle;
			submitButton = options.submit;
			onOpenCallback = options.onOpenCallback;
			onCloseCallback = options.onCloseCallback;

			// parametrizas variaveis internas

			toggleButton.on('click', function(event){
				toggleNewsletter();
				event.stopPropagation();
			});

			submitButton.on('click', function(event){
				// submit form.
				// TODO: make request
				event.stopPropagation();
				// toggleNewsletter(false);
			});

			element.on('click', function(event){
				return false;
			});

			$("html").on("click", function(event) { 
				if (isOpen()) {
				    if($(event.target).parents().index(element) == -1) {
			    		toggleNewsletter(false);
			    	}
				}
			});
		},
		toggle : function() {
		   toggleNewsletter();
		}
	};

	//
	// PRIVATE METHODS
	//

	/**
	 * Returns if the subscription box is open or not
	 * @return BOOL
	 */
	var isOpen = function() {
		return element.height() != 0;
	};
	
	/**
	 * Toggles the subscription box open or closed
	 * @param  bool force open or close
	 * @return void
	 */
	var toggleNewsletter = function(openOrClose){
		var toggledHeight = 250;
		var toggled;

		if (typeof openOrClose != 'undefined') toggled = openOrClose ? toggledHeight : 0;
		else toggled = element.height() == 0 ? toggledHeight : 0;

		element.animate({"height":toggled + "px"}, 'fast', function(){
			if (toggled == 0) {
				// closed
				// execute callback
				onCloseCallback();
			}
			else{
				// open
				// execute callback
				onOpenCallback();
			}
		});
	};

})( jQuery );

/**
 * Runtime
 */
$(document).ready(function(){
	$("body").radarBackground({anchorPointY:0.05, color:"#ebebeb"});
	$().showHideCoordinator({ 
		elements: [
			{ element: $("#arrow-1")},
			{ element: $("#arrow-2"), ttl: 6000},
			{ element: $("#arrow-3"), ttl: 2000},
			{ element: $("#arrow-4"), ttl: 4000},
			{ element: $("#arrow-5"), ttl: 5000},
			{ element: $("#arrow-6"), ttl: 3000},
			{ element: $("#arrow-7"), ttl: 5000},
			{ element: $("#arrow-8"), ttl: 3000},
			{ element: $("#arrow-9"), ttl: 3000},
			{ element: $("#arrow-9a"), ttl: 1000},
			{ element: $("#arrow-10"), ttl: 3000},
			{ element: $("#arrow-11"), ttl: 3000},
			{ element: $("#arrow-12"), ttl: 4000},
			{ element: $("#arrow-13"), ttl: 3000},
			{ element: $("#arrow-14"), ttl: 8000},
			{ element: $("#arrow-15"), ttl: 10000},
			{ element: $("#arrow-16"), ttl: 4000},
			{ element: $("#arrow-17"), ttl: 3800},
			{ element: $("#arrow-18"), ttl: 9000}

		], animationTime: 0.5}
	);
	$("#videoPlaceHolder").videoAction({
								videoID: "9vN7GegZRZ4",
								width: 231,
								height: 410,
								ytParams: { autoplay: 1, controls: 0, iv_load_policy:3, loop:1, playlist: "9vN7GegZRZ4", rel: 0, showsearch: 0, showinfo: 0, modestbranding: 0 },
								cueTimes: "500,5000,8000,17000,24000,33000,40000,48000,52000,55000,58000,67000,77000,85100,91000,100000,127000,133400,135000",
								cueTimeCallBack: function(){ $().showHideCoordinator("showNext"); },
								endedCallBack: function(){ $().showHideCoordinator("hideAll"); },
								replayCallback: function(){ $().showHideCoordinator("reset"); }
							});
	$("#iphone").scaleAndPositionFromScreenHeight({
					maxHeight: 740,		// max height
					minHeight: 500,		// min height
					maxScale: 1.0,		// scale when at maxH
					minScale: 0.5,		// scale when at minH
					maxBottom: -1.0,	// bottom when at maxH
					minBottom: -130		// bottom when at minH
				});
	$("#subscription").subscription({
							toggle: $(".newsletter"),
							submit: $("#subscription_send"),
							onOpenCallback: function(){
								document.getElementById("videoPlaceHolder").pauseVideo();
								$("#iphone").animate({"opacity":"0.5"}, 'slow');
								$().showHideCoordinator("hideAll");
							},
							onCloseCallback: function(){
								document.getElementById("videoPlaceHolder").playVideo();
								$("#iphone").animate({"opacity":"1.0"}, 'fast');
							}
					  });
});