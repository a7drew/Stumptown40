$.support.cors = true;
$.connection.hub.url = 'http://stumptown40.azurewebsites.net/signalr';
var chat = $.connection.navigationHub;

var gRacerCache;
$.getJSON('http://stumptown40.azurewebsites.net/api/cars?callback=?', function(e) {
    gRacerCache = e;
});

chat.client.onNavigate = function (viewName, jsonData) {
    $("body").removeClass().addClass(viewName);
	var app =  $.sammy('#view', function() {
		this.use('Handlebars', 'hb');
		this.bind('#'+viewName, function(event, viewName) {
	      	var context = this;	
			var obj = jQuery.parseJSON(jsonData);
			var location = window.location.hash;
			var noletter = /^[0-9a]+$/;
			var s40 = 'https://platform.postano.com/apiproxy/accounts/297/projects/32243/products/4524/posts?count=99&sort=post_time&cache=none';
			
			//race view
		    var raceView = function() {

		        context.racer1Id = obj.currentRace[0].racer1;
		        context.racer2Id = obj.currentRace[0].racer2;

		        context.upcomingracer1Id = obj.upcomingRace[0].nextRacer1;
		        context.upcomingracer2Id = obj.upcomingRace[0].nextRacer2;
		        
		        context.racer1CarNumber = obj.currentRace[0].racer1 > 0 ? gRacerCache[(obj.currentRace[0].racer1) - 1].CarNumber : "???";
		        context.racer2CarNumber = obj.currentRace[0].racer2 > 0 ? gRacerCache[(obj.currentRace[0].racer2) - 1].CarNumber : "???";
		        
		        context.upcomingracer1CarNumber = obj.upcomingRace[0].nextRacer1 > 0 ? gRacerCache[(obj.upcomingRace[0].nextRacer1) - 1].CarNumber : "";
		        context.upcomingracer2CarNumber = obj.upcomingRace[0].nextRacer2 > 0 ? gRacerCache[(obj.upcomingRace[0].nextRacer2) - 1].CarNumber : "";

		        context.racer1 = context.racer1Id > 0 ? gRacerCache[(obj.currentRace[0].racer1) - 1].Name : "???";
		        context.racer2 = context.racer2Id > 0 ? gRacerCache[(obj.currentRace[0].racer2) - 1].Name : "???";

		        // at the end of the race, the will be only two cars left
		        context.nextRacer1 = context.upcomingracer1Id > 0 ? gRacerCache[(obj.upcomingRace[0].nextRacer1) - 1].Name : "";
		        context.nextRacer2 = context.upcomingracer2Id > 0 ? gRacerCache[(obj.upcomingRace[0].nextRacer2) - 1].Name : "";

		        context.winnerId = obj.winnerId;
		        context.currentRound = obj.currentRound;


		        context.render('../Templates/' + viewName + '.hb', jsonData, function(html) {
		            context.$element().html(html);
		            context.$element().addClass("show");
		        }).then(function() {
		            context.$element().find("img").error(function() {
		                $(this).hide();
		                // or $(this).css({visibility:"hidden"}); 
		            });
		            //winner
		            if (context.racer1Id === context.winnerId) {
		                context.$element().addClass("winnerDeclared");
		                $('.racer[data-id="' + context.racer1Id + '"]').addClass("winner");
		                $('.racer[data-id="' + context.racer2Id + '"]').addClass("loser");
		            } else if (context.racer2Id === context.winnerId) {
		                context.$element().addClass("winnerDeclared");
		                $('.racer[data-id="' + context.racer2Id + '"]').addClass("winner");
		                $('.racer[data-id="' + context.racer1Id + '"]').addClass("loser");
		            } else {
		                $('.racer[data-id="' + context.racer1Id + '"],.racer[data-id="' + context.racer2Id + '"]').removeClass("winner");
		                $('.racer[data-id="' + context.racer1Id + '"],.racer[data-id="' + context.racer2Id + '"]').removeClass("loser");
		            }
		        });
		    };
			
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
	
/*for Ryan to debug quickly	
if(window.location.hash == "#home") {
	chat.client.onNavigate("home", '');
}	



if(window.location.hash == "#sponsors") {
chat.client.onNavigate("sponsors", '');
}


if(window.location.hash == "#gallery") {
	chat.client.onNavigate("gallery", '');
}	
*/


});