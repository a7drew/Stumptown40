$.support.cors = true;
$.connection.hub.url = 'http://stumptown40.azurewebsites.net/signalr';
var chat = $.connection.navigationHub;

chat.client.onNavigate = function (viewName, jsonData) {
    $("body").removeClass().addClass(viewName);
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
			    $.getJSON('http://stumptown40.azurewebsites.net/api/cars?callback=?', function (e) {
	                gRacerCache = e;
					context.racer1Id = obj.currentRace[0].racer1;
					context.racer2Id = obj.currentRace[0].racer2;
										
					context.upcomingracer1Id = obj.upcomingRace[0].nextRacer1;
					context.upcomingracer2Id = obj.upcomingRace[0].nextRacer2;
					
					context.racer1 = context.racer1Id > 0 ? gRacerCache[(obj.currentRace[0].racer1) - 1].Name : "???";
					context.racer2 = context.racer2Id > 0 ? gRacerCache[(obj.currentRace[0].racer2) - 1].Name : "???";
									 
					
					context.nextRacer1 = context.racer1Id > 0 ? gRacerCache[(obj.upcomingRace[0].nextRacer1) - 1].Name : "???";
					context.nextRacer2 = context.racer2Id > 0 ? gRacerCache[(obj.upcomingRace[0].nextRacer2) - 1].Name : "???";
					
					context.winnerId = obj.winnerId;
					context.currentRound = obj.currentRound;
										
					
					context.render('../Templates/'+viewName+'.hb', jsonData, function(html){
								context.$element().html(html);
								context.$element().addClass("show");						
			      	}).then(function() { 
						context.$element().find("img").error(function () { 
						    $(this).hide();
						    // or $(this).css({visibility:"hidden"}); 
						});
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
					
					}).then(function() {
							//racer marquee
							$.ajax({
					          	type: "GET",
					          	dataType: "jsonp",
								jsonpCallback:"jsonp",
					          	async: true,
					          	cache: false,
					          	url: s40,
					          	success: function (data) {
									var items = 20;
									var w = parseInt(items * 160);
									context.$element().append('<div class="marqueewrapper" id="marqueewrapper"><marquee style="width:'+w+'px" id="marquee" class="racersmarquee"></marquee></div>');
									
									setTimeout(function(){
										$("#marqueewrapper").addClass("on");
									}, 500);
									
									
									for (x = 0; x < items; x++) {
										var photos = data.posts[x];
										
										photos.newtext = (photos.text != null) ? photos.text : '';
										photos.number = (photos.newtext.match(noletter) != null) ? photos.newtext : '';
										
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
		      	});
			}
			
			if(location === "#raceView") {				
				context.$element().removeClass("winnerDeclared");
				context.$element().removeClass("show");
				$("#marqueewrapper").removeClass("on");
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

	
var isChrome = navigator.userAgent.toLowerCase().indexOf('chrome') > -1;

// Start the connection.
$.connection.hub.start({
    jsonp: isChrome
}).done(function () {
	
/*for Ryan to debug quickly	*/
if(window.location.hash == "#home") {
	chat.client.onNavigate("home", '');
}	



if(window.location.hash == "#sponsors") {
chat.client.onNavigate("sponsors", '');
}


if(window.location.hash == "#gallery") {
	chat.client.onNavigate("gallery", '');
}	



});