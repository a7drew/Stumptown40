if (!window.location.hash) {
	history.pushState(null, 'Home', '#home');
}

$.support.cors = true;
$.connection.hub.url = 'http://stumptown40.cloudapp.net/signalr';
var chat = $.connection.navigationHub;

function SetActiveLink(name){
    var nav = $('nav');
    nav.children().removeClass('active');
    nav.find('a[href="#/'+name+'/"]').addClass('active');
}

chat = $.connection.navigationHub;

var showView = function(viewId, data) {
	$.sammy('#view', function() {
		this.use('Handlebars', 'hb');
		this.get('#'+viewId, function() {
			
			if(data != null) {
				console.log(data);
			}
			
			SetActiveLink(viewId);
	    	this.title = viewId;
	
			this.partial('../Templates/'+viewId+'.hb');
	   });
	}).run();
}  

chat.client.onNavigate = function (viewName, jsonData) {
	history.pushState(null, viewName, '#'+viewName);
	showView(viewName, jsonData);
};	


$.sammy(function () {
       this.get('#:controller', function () {
           switch (this.params.controller) {
           case 'home':
               showView('home', null);
               break;
           case 'gallery':
               showView('gallery', null);
               break;
           case 'sponsors':
               showView('sponsors', null);
               break;
			case 'race':
               showView('race', null);
               break;
           default:
               alert('unexpected: ' + this.params.controller);
               break;
           }
       });
}).run();
	



 
// Start the connection.
$.connection.hub.start().done(function () {
	
});



// racers lookup
  //$.getJSON('http://stumptown40.cloudapp.net/api/racers?callback=?', function(e) {
	//console.log(e)
      //$('#views').append('<li><strong>' + e.length + ' racers received, the name of the first racer is ' + e[0].Name + '.</strong></li>');
 // });