$.support.cors = true;
$.connection.hub.url = 'http://stumptown40.cloudapp.net/signalr';
var chat = $.connection.navigationHub;

function SetActiveLink(name){
    var nav = $('nav');
    nav.children().removeClass('active');
    nav.find('a[href="#/'+name+'/"]').addClass('active');
}





chat.client.onNavigate = function (viewName, jsonData) {
				
		var app =  $.sammy('#view', function() {
	
			this.use('Handlebars', 'hb');
			this.bind('#'+viewName, function(event, viewName) {
			      	var context = this;
			

					SetActiveLink(viewName);
					
				
				
				
					var obj = jQuery.parseJSON(jsonData);
					
					console.log(obj.currentRace[0].racer1)
				
					context.racer1 = obj.currentRace[0].racer1;
					context.racer2 = obj.currentRace[0].racer2;
					
					
					
					$.getJSON('http://stumptown40.cloudapp.net/api/racers?callback=?', function (e) {
		                gRacerCache = e;
		               	console.log(gRacerCache[context.racer1])
		            });
				
				
			      	this.render('../Templates/'+viewName+'.hb', viewName, function(html){					
			        	context.$element().html(html);
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