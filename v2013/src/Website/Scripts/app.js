$.support.cors = true;
$.connection.hub.url = 'http://stumptown40.cloudapp.net/signalr';
var chat = $.connection.navigationHub;

function SetActiveLink(name){
    var nav = $('nav');
    nav.children().removeClass('active');
    nav.find('a[href="#/'+name+'/"]').addClass('active');
}





chat.client.onNavigate = function (viewName, jsonData) {
		console.log("singlar")
		var app = Sammy('#view', function() {
	
			this.use('Handlebars', 'hb');
			console.log("app")

			this.bind('#'+viewName, function(e, viewName) {
			      	var context = this;
			
					console.log(e)
					SetActiveLink(viewName);
					
				  	context.title = jsonData;
				
				
			      	this.render('../Templates/'+viewName+'.hb', viewName, function(html){					
			        	context.$element().html(html);
			      	});
			});
			
			this.get('#'+viewName);
			
		});
		

		app.trigger('#'+viewName, viewName);
		
		app.setLocation('#'+viewName);
        //app.runRoute('get', '#'+viewName);
		app.run();
		
		

};	

	


// Start the connection.
$.connection.hub.start().done(function () {

});