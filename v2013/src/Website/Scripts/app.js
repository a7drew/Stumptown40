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

			//race view
			var raceView = function() {
			    $.getJSON('http://stumptown40.azurewebsites.net/api/racers?callback=?', function (e) {
	                gRacerCache = e;
					
					context.racer1Id = obj.currentRace[0].racer1;
					context.racer2Id = obj.currentRace[0].racer2;
					
					context.racer1 = context.racer1Id > 0 ? gRacerCache[(obj.currentRace[0].racer1) - 1].Name : "???";
					context.racer2 = context.racer2Id > 0 ? gRacerCache[(obj.currentRace[0].racer2) - 1].Name : "???";
									 
					
					context.nextRacer1 = context.racer1Id > 0 ? gRacerCache[(obj.upcomingRace[0].nextRacer1) - 1].Name : "???";
					context.nextRacer2 = context.racer2Id > 0 ? gRacerCache[(obj.upcomingRace[0].nextRacer2) - 1].Name : "???";
					
					context.winnerId = obj.winnerId;
					context.currentRound = obj.currentRound;
					
					
					context.render('../Templates/'+viewName+'.hb', jsonData, function(html){					
			        	context.$element().html(html);
			      	}).then(function() { 
						//winner
				       	if(context.racer1Id === context.winnerId) {
							$('.card[data-id="'+context.racer1Id+'"]').addClass("winner");

						} else if(context.racer2Id === context.winnerId) {
							$('.card[data-id="'+context.racer2Id+'"]').addClass("winner");
						} else {
							$('.card[data-id="'+context.racer1Id+'"], p[data-id="'+context.racer2Id+'"]').removeClass("winner");
						}
					});
					
	            });
			}
			
			//gallery view
			var galleryView = function() {
				context.render('../Templates/'+viewName+'.hb', jsonData, function(html){					
		        	context.$element().html(html);
		      	}).then(function() {
						var token = '51853638.1fb234f.976879fb4353497caa70fa47810b6e3d';
						var count = 40;
						var postano = 'http://api.postano.com/jsonp/?Action=GetPosts&PostanoPublicKey=7d14629360370691c3ed&postano_id=83380&Count=100&jsonp=jsonp';
						 var getNewphoto = function() {
							$.ajax({
					          	type: "GET",
					          	dataType: "jsonp",
								jsonpCallback:"jsonp",
					          	async: true,
					          	cache: false,
					          	url: postano,
					          	success: function (data) {
									var newphoto = data.posts[0];
									newphoto.number =  newphoto.text.replace(/^#/, '');
									var newphotoId = newphoto.post_id;
									var prevphotoId = parseInt($('#photos li:nth-child(1)').attr('data-id'));
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
						
					   $.ajax({
				          	dataType: "jsonp",
							jsonpCallback:"jsonp",
				          	url: postano,
				          	success: function (data) {
								var l = data.posts.length;
								for (x = 0; x < l; x++) {
									var photos = data.posts[x];
									photos.number =  photos.text.replace(/^#/, '');
									context.render('../Templates/photos.hb', photos).prependTo($("#photos"));
								}
							},
						complete: function(){
								(function poll() {
						            if (window.location.hash != '#gallery')
						                return;

						            setTimeout(function ()
						            {
						                //getNewphoto();
						                //poll();
						            }, 5000);
						       })();
						}
					});
			
				});
			}
			
			if(location === "#raceView") {
				raceView();
			} else if(location === "#gallery") {
				galleryView();
			} else {
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