$.support.cors = true;
$.connection.hub.url = 'http://stumptown40.cloudapp.net/signalr';
var chat = $.connection.navigationHub;

function SetActiveLink(name){
    var nav = $('nav');
    nav.children().removeClass('active');
    nav.find('a[href="#/'+name+'/"]').addClass('active');
}

var showView = function(viewId, data) {

	$.sammy('#view', function() {
		this.use('Handlebars', 'hb');

		this.get('#'+viewId, function(context) {
			$(context.$element()).empty();
			SetActiveLink(viewId);
	    	this.title = data;
	
			console.log(this.title)
		
			
			this.render('../Templates/'+viewId+'.hb').appendTo(context.$element());
	   });
	
	}).run();
}  

chat.client.onNavigate = function (viewName, jsonData) {
	console.log('data: '+jsonData)
	history.pushState(null, viewName, '#'+viewName);
//	console.log(jsonData)
	showView(viewName, jsonData);
};	

	


// Start the connection.
$.connection.hub.start().done(function () {

});