$.support.cors = true;
$.connection.hub.url = 'http://stumptown40.cloudapp.net/signalr';
var chat = $.connection.navigationHub;

chat.client.onNavigate = function (viewName, jsonData) {			
	var app =  $.sammy('#view', function() {
		this.use('Handlebars', 'hb');
		this.bind('#'+viewName, function(event, viewName) {
	      	var context = this;
			var obj = jQuery.parseJSON(jsonData);

			$.getJSON('http://stumptown40.cloudapp.net/api/racers?callback=?', function (e) {
                gRacerCache = e;

				//console.log((obj.currentRace[0].racer1) - 1)
				context.racer1 = gRacerCache[(obj.currentRace[0].racer1) - 1].Name;
				context.racer2 = gRacerCache[(obj.currentRace[0].racer2) - 1].Name;
				
				context.render('../Templates/'+viewName+'.hb', viewName, function(html){					
		        	context.$element().html(html);
		      	});
            });
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