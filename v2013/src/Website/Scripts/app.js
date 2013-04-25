$.support.cors = true;
$.connection.hub.url = 'http://stumptown40.cloudapp.net/signalr';
var chat = $.connection.navigationHub;

chat.client.onNavigate = function (viewName, jsonData) {			
	var app =  $.sammy('#view', function() {
		this.use('Handlebars', 'hb');
		this.bind('#'+viewName, function(event, viewName) {
	      	var context = this;
			var obj = jQuery.parseJSON(jsonData);
			var location = window.location.hash;
			
			context.title = jsonData;
			
			var raceView = function() {
				$.getJSON('http://stumptown40.cloudapp.net/api/racers?callback=?', function (e) {
	                gRacerCache = e;
	
					context.racer1 = gRacerCache[(obj.currentRace[0].racer1) - 1].Name;
					context.racer2 = gRacerCache[(obj.currentRace[0].racer2) - 1].Name;
					
					context.racer1Id = obj.currentRace[0].racer1;
					context.racer2Id = obj.currentRace[0].racer2;
					
					context.nextRacer1 = gRacerCache[(obj.upcomingRace[0].nextRacer1) - 1].Name;
					context.nextRacer2 = gRacerCache[(obj.upcomingRace[0].nextRacer2) - 1].Name;
					
					context.winnerId = obj.winnerId;
					
					context.winner = '';
					
					context.render('../Templates/'+viewName+'.hb', viewName, function(html){					
			        	context.$element().html(html);
			      	}).then(function() { 
				

						//winner
				       	if(context.racer1Id === context.winnerId) {
							$('p[data-id="'+context.racer1Id+'"]').addClass("winner");

						} else if(context.racer2Id === context.winnerId) {
							$('p[data-id="'+context.racer2Id+'"]').addClass("winner");
						} else {
							$('p[data-id="'+context.racer1Id+'"], p[data-id="'+context.racer2Id+'"]').removeClass("winner");
						}
					});
					
	            });
			}
			
			if(location === "#raceView") {
				raceView();
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

});