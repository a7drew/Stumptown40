// Declare a proxy to reference the hub. 
	$.support.cors = true;
	$.connection.hub.url = 'http://stumptown40.cloudapp.net/signalr';

	var chat = $.connection.navigationHub;
	
	
	chat.client.onNavigate = function (viewName, jsonData) {
		var encodedName = $('<div />').text(viewName).html();
		var encodedMsg = $('<div />').text(jsonData).html();
		history.pushState(null, viewName, '#/'+viewName+'/');	


	var app = $.sammy('#view', function() {
		
		if (!window.location.hash) {
			history.pushState(null, 'Home', '#/home/');
		}
	
	    this.use('Handlebars', 'hb');
	
		function SetActiveLink(name){
		    var nav = $('nav');
		    nav.children().removeClass('active');
		    nav.find('a[href="#/'+name+'/"]').addClass('active');
		}
		
		this.get('#/home/', function() {
			SetActiveLink('home');
			
			console.log(viewName, jsonData)
			
	      	this.title = 'Home View';
	      	this.partial('../Templates/home.hb');
	    });
	
		this.get('#/gallery/', function() {
			SetActiveLink('gallery');
			console.log(viewName, jsonData)
	      	this.title = 'Gallery View';
	      	this.partial('../Templates/gallery.hb');
	    });

	    this.get('#/sponsors/', function() {
			SetActiveLink('sponsors');
			console.log(viewName, jsonData)
	      	this.title = 'Sponsors View';
	      	this.partial('../Templates/sponsors.hb');
	    });
	
	
	    this.get('#/race/', function() {
			SetActiveLink('race');
			console.log(viewName, jsonData)
	      	this.title = 'Race View';
	      	this.partial('../Templates/race.hb');
	    });
	
	  });

	  $(function() {
	    app.run()
	  });

	 };


// what is this for?
  $.getJSON('http://stumptown40.cloudapp.net/api/racers?callback=?', function(e) {
	console.log(e)
      //$('#views').append('<li><strong>' + e.length + ' racers received, the name of the first racer is ' + e[0].Name + '.</strong></li>');
  });
 
  // Start the connection.
  $.connection.hub.start().done(function () {
      //$('#views').append('<li><strong>Ready to receive messages.</strong></li>');
  });