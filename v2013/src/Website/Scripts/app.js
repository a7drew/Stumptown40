$.support.cors = true;
$.connection.hub.url = 'http://stumptown40.azurewebsites.net/signalr';
var chat = $.connection.navigationHub;

chat.client.onNavigate = function (viewName, jsonData) {			
	var app =  $.sammy('#view', function() {
		this.use('Handlebars', 'hb');
		this.bind('#'+viewName, function(event, viewName) {
	      	var context = this;	
			var obj = jQuery.parseJSON(jsonData);
			var location = window.location.hash;
			var noletter = /^[0-9a]+$/;
			var s40 = 'http://api.postano.com/jsonp/?Action=GetPosts&PostanoPublicKey=7d14629360370691c3ed&postano_id=83380&Count=100&jsonp=jsonp';
			
			//race view
			var raceView = function() {			
			    $.getJSON('http://stumptown40.azurewebsites.net/api/racers?callback=?', function (e) {
	                gRacerCache = e;
					context.racer1Id = obj.currentRace[0].racer1;
					context.racer2Id = obj.currentRace[0].racer2;
										
					context.upcomingracer1Id = obj.upcomingRace[0].nextRacer1;
					context.upcomingracer2Id = obj.upcomingRace[0].nextRacer2;
					
					context.racer1 = context.racer1Id > 0 ? gRacerCache[(obj.currentRace[0].racer1)].Name : "???";
					context.racer2 = context.racer2Id > 0 ? gRacerCache[(obj.currentRace[0].racer2)].Name : "???";
									 
					
					context.nextRacer1 = context.racer1Id > 0 ? gRacerCache[(obj.upcomingRace[0].nextRacer1)].Name : "???";
					context.nextRacer2 = context.racer2Id > 0 ? gRacerCache[(obj.upcomingRace[0].nextRacer2)].Name : "???";
					
					context.winnerId = obj.winnerId;
					context.currentRound = obj.currentRound;
										
					
					context.render('../Templates/'+viewName+'.hb', jsonData, function(html){
								context.$element().html(html);
								context.$element().addClass("show");						
			      	}).then(function() { 
						//winner

							if(context.racer1Id === context.winnerId) {
								context.$element().addClass("winnerDeclared");
								$('.racer[data-id="'+context.racer1Id+'"]').addClass("winner");
								$('.racer[data-id="'+context.racer2Id+'"]').addClass("loser");
							} else if(context.racer2Id === context.winnerId) {
								context.$element().addClass("winnerDeclared");
								$('.racer[data-id="'+context.racer2Id+'"]').addClass("winner");
								$('.racer[data-id="'+context.racer1Id+'"]').addClass("loser");
							} else {
$('.racer[data-id="'+context.racer1Id+'"],.racer[data-id="'+context.racer2Id+'"]').removeClass("winner");							$('.racer[data-id="'+context.racer1Id+'"],.racer[data-id="'+context.racer2Id+'"]').removeClass("loser");
							}
						
				       	
						
							//racer marquee
							$.ajax({
					          	type: "GET",
					          	dataType: "jsonp",
								jsonpCallback:"jsonp",
					          	async: true,
					          	cache: false,
					          	url: s40,
					          	success: function (data) {
									var items = data.posts.length;
									var w = parseInt(items * 160);
									$("body").append('<div class="marqueewrapper" id="marqueewrapper"><marquee style="width:'+w+'px" id="marquee" class="racersmarquee"></marquee></div>');
									for (x = 0; x < items; x++) {
										var photos = data.posts[x];
										 photos.number =  (photos.text.replace(/^#/, '').match(noletter) != null) ? photos.text.replace(/^#/, '') : '' ;
										
										context.render('../Templates/marquee.hb', photos, function(e){
											result = e;
											return
										}).then(function(result) {
											$("#marquee").prepend(result);
										})
									}
								}
							});
					});
	            });
			}
			
			//gallery view
			var galleryView = function() {	
					
				context.render('../Templates/'+viewName+'.hb', jsonData, function(html){					
		        	context.$element().empty().html(html);
		      	}).then(function() {
			
							var timeoutId = window.setTimeout(function() {}, 0);
							while (timeoutId--) {
							    window.clearTimeout(timeoutId); 
							}


							var intervalId = window.setInterval(function() {}, 0);
							while (intervalId--) {
							    window.clearInterval(intervalId);
							}
						 var getNewphoto = function() {
							$.ajax({
					          	type: "GET",
					          	dataType: "jsonp",
								jsonpCallback:"jsonp",
					          	async: true,
					          	cache: false,
					          	url: s40,
					          	success: function (data) {
									var newphoto = data.posts[0];
									newphoto.number =  (newphoto.text.replace(/^#/, '').match(noletter) != null) ? newphoto.text.replace(/^#/, '') : '' ;									
									var newphotoId = newphoto.post_id;
									var prevphotoId = (!isNaN(parseInt($('#photos li:nth-child(1)').attr('data-id')))) ? parseInt($('#photos li:nth-child(1)').attr('data-id')) : newphotoId;
									//console.log(newphotoId,prevphotoId)
									if (newphotoId !== prevphotoId) {
										context.render('../Templates/photos.hb', newphoto, function(e){
											result = e;
											return
										}).then(function(result) {
											$("#photos").prepend(result);
										});	
									}
								}
							});
						}
						var  l = 0;
						var myList = [];
					   $.ajax({
				          	dataType: "jsonp",
							jsonpCallback:"jsonp",
				          	url: s40,
				          	success: function (data) {
								function shuffle(o){ //v1.0
								for(var j, x, i = o.length; i; j = parseInt(Math.random() * i), x = o[--i], o[i] = o[j], o[j] = x);
								return o;
								};

								var myArray = data.posts;
								newArray = shuffle(myArray);	
								l = newArray.length;
								for (x = 0; x < l; x++) {
									var photos = newArray[x];
									
									photos.number = (photos.text.replace(/^#/, '').match(noletter) != null) ? photos.text.replace(/^#/, '') : '' ;
									console.log(photos.number)
									
									context.render('../Templates/photos.hb', photos).prependTo($("#photos"));
								}
							},
						complete: function(){
								var min = 1;
								var timer = 3000;
								var highlight = function() {
									var max = $("#photos li").size();
									var randomnumber = Math.floor(Math.random() * (max - min + 1)) + min;
									$("#photos li").removeClass("on");
									$("#photos").find("li:nth-child("+randomnumber+")").addClass("on");
									setTimeout(function () {
										window.requestAnimationFrame(highlight);
						            }, timer);
								}
								
								var highlight2 = function() {
									var max = $("#photos li").size();
									var randomnumber = Math.floor(Math.random() * (max - min + 1)) + min;
									$("#photos li").removeClass("on2");
									$("#photos").find("li:nth-child("+randomnumber+")").addClass("on2");
									setTimeout(function () {
										window.requestAnimationFrame(highlight2);
						            }, 1000);
								}
								
								var highlight3 = function() {
									var max = $("#photos li").size();
									var randomnumber = Math.floor(Math.random() * (max - min + 1)) + min;
									$("#photos li").removeClass("on3");
									$("#photos").find("li:nth-child("+randomnumber+")").addClass("on3");
									setTimeout(function () {
										window.requestAnimationFrame(highlight3);
						            }, 1200);
								}
								
								var highlight4 = function() {
									var max = $("#photos li").size();
									var randomnumber = Math.floor(Math.random() * (max - min + 1)) + min;
									$("#photos li").removeClass("on4");
									$("#photos").find("li:nth-child("+randomnumber+")").addClass("on4");
									setTimeout(function () {
										window.requestAnimationFrame(highlight4);
						            }, 1500);
								}
								
								var highlight5 = function() {
									var max = $("#photos li").size();
									var randomnumber = Math.floor(Math.random() * (max - min + 1)) + min;
									$("#photos li").removeClass("on5");
									$("#photos").find("li:nth-child("+randomnumber+")").addClass("on5");
									setTimeout(function () {
										window.requestAnimationFrame(highlight5);
						            }, 2000);
								}
								
								window.requestAnimationFrame(highlight);
								window.requestAnimationFrame(highlight2);
								window.requestAnimationFrame(highlight3);
								window.requestAnimationFrame(highlight4);
								window.requestAnimationFrame(highlight5);
								
								(function poll() {
						            if (window.location.hash != '#gallery')
						                return;

						            setTimeout(function ()
						            {
						                getNewphoto();
						                poll();
						            }, 5000);
						       })();
						
						
						}
					});
			
				});
			}
			
			if(location === "#raceView") {				
				context.$element().removeClass("winnerDeclared");
				context.$element().removeClass("show");
				setTimeout(function(){
					raceView();
				},500);
			} else if(location === "#gallery") {
				galleryView();
				$("#marqueewrapper").remove();
			} else {
				$("#marqueewrapper").remove();
				context.render('../Templates/'+viewName+'.hb', viewName, function(html){					
		        	context.$element().html(html);
		      	});	
			}
			
		});

		this.get('', function(context) {
			app.setLocation('#'+viewName);
		});

		// Catch-all for 404 errors:
		    this.get(/.*/, function() { 
		    console.log('404... come on, really?');
		});

	});
	app.unload();
	app.run();
	app.trigger('#'+viewName, viewName);
	app.destroy();	
};	

	


// Start the connection.
$.connection.hub.start().done(function () {
	
/* for Ryan to debug quickly	
if(window.location.hash == "#home") {
	chat.client.onNavigate("home", '');
}	
*/
	
if(window.location.hash == "#gallery") {
	chat.client.onNavigate("gallery", '');
}

/*if(window.location.hash == "#sponsors") {
chat.client.onNavigate("sponsors", '');
}*/

	


});