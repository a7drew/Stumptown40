// MODELS ======================================================================
//
// JSONP URLs:
//	http://localhost:28555
//	http://stumptown40.cloudapp.net
//

var webSvcUrl = 'http://stumptown40.cloudapp.net';

var Bracket = Backbone.Model.extend({});

var Brackets = Backbone.Collection.extend({
	model: Bracket,
	sync: function(method, model, options) {  
		options.timeout = 10000;  
		options.dataType = "jsonp";  
		return Backbone.sync(method, model, options);  
	},
	url: function() {
		return webSvcUrl + "/brackets";
	}
});

var brackets = new Brackets();

// -----------------------------------------------------------------------------

var Round = Backbone.Model.extend({});

var Rounds = Backbone.Collection.extend({
	model: Round,
	url: function () {
		return webSvcUrl + "/rounds/index/" + this.BracketId;
	},
	sync: function(method, model, options) {  
		options.timeout = 10000;  
		options.dataType = "jsonp";  
		return Backbone.sync(method, model, options);  
	}
});

var rounds = new Rounds();
// -----------------------------------------------------------------------------

var MatchHeader = Backbone.Model.extend({
	url: function () {
		return webSvcUrl + "/matches/header/" + this.RoundId;
	},
	sync: function(method, model, options) {  
		options.timeout = 10000;  
		options.dataType = "jsonp";  
		return Backbone.sync(method, model, options);  
	}
});

var matchHeader = new MatchHeader();

// -----------------------------------------------------------------------------

var Match = Backbone.Model.extend({});

var Matches = Backbone.Collection.extend({
	model: Match,
	url: function ()
	{
		return webSvcUrl + "/matches/index/" + this.RoundId;
	},
	sync: function(method, model, options) {  
		options.timeout = 10000;  
		options.dataType = "jsonp";  
		return Backbone.sync(method, model, options);  
	}
});

var matches = new Matches();

// -----------------------------------------------------------------------------

var Race = Backbone.Model.extend({
	url: function () {
		return webSvcUrl + "/matches/detail/" + this.MatchId;
	},
	sync: function(method, model, options) {  
		options.timeout = 10000;  
		options.dataType = "jsonp";  
		return Backbone.sync(method, model, options);  
	}
});

var race = new Race();

// -----------------------------------------------------------------------------

var Person = Backbone.Model.extend({});

var People = Backbone.Collection.extend({
	model: Person,
	url: webSvcUrl + "/racers",
	sync: function(method, model, options) {  
		options.timeout = 10000;  
		options.dataType = "jsonp";  
		return Backbone.sync(method, model, options);  
	}
});

var people = new People();


// -----------------------------------------------------------------------------
// GIANT hack for SetWinner() because i don't know how to do it in backbone yet

function PostWinner(matchId, winningRacerId, losingRacerId) {

	$.ajax({
		type: 'post',
		url: webSvcUrl + '/matches/update',
		data: { matchId: matchId, winningRacerId:winningRacerId, losingRacerId:losingRacerId },
		success: function () {
			$('#raceTemplate').append('<input id="hiddenPostedWinner" type="hidden" value="' + winningRacerId + '" />');
		}
	});

}

// VIEWS =======================================================================

var HomeView = Backbone.View.extend({
	tagName: "div",
	template: _.template($('#home-template').html()),
	render: function () {
		this.$el.html(this.template());
			return this;
	}
});

// -----------------------------------------------------------------------------

var BracketView = Backbone.View.extend({
	tagName: "div",
	template: _.template($('#bracket-template').html()),
	render: function () {
		this.$el.html(this.template({ list: this.collection.toJSON() }));
		return this;
	}
});

// -----------------------------------------------------------------------------

var RoundView = Backbone.View.extend({
	tagName: "div",
	template: _.template($('#round-template').html()),
	render: function () {
		this.$el.html(this.template({ list: this.collection.toJSON() }));
		return this;
	}
});

// -----------------------------------------------------------------------------

var MatchView = Backbone.View.extend({
	tagName: "div",
	template: _.template($('#match-template').html()),
	render: function () {
		this.$el.html(this.template({ list: this.collection.toJSON() }));
		//this is not an elegant solution. I need a class on the parent to identify the race "raceover" or "notraced" something like that...
		setTimeout(function(){
			$("#matchList").find(".winner").parent().addClass("race_over");

		}, 0);
		return this;

	}
});

// -----------------------------------------------------------------------------

var MatchHeaderView = Backbone.View.extend({
	tagName: "div",
	template: _.template($('#match-header-template').html()),
	initialize: function () {
		_.bindAll(this, 'render');
	},
	render: function () {
		this.$el.html(this.template({ model: this.model.toJSON() }));
		return this;
	}
});

// -----------------------------------------------------------------------------

var RaceView = Backbone.View.extend({
	tagName: "div",
	template: _.template($('#race-template').html()),
	initialize: function () {
		_.bindAll(this, 'render');
	},
	events: {
		"click #racer1Won" : "racer1Won",
		"click #racer2Won" : "racer2Won"
	},
	racer1Won : function () {

		var matchId = $('#racer1Won').attr('data-matchId');
		var winningRacerId = $('#racer1Won').attr('data-racerId');
		var losingRacerId = $('#racer2Won').attr('data-racerId');

		PostWinner(matchId, winningRacerId, losingRacerId);
		this.showWinner(winningRacerId, $(racer1Won).text());
	},
	racer2Won : function () {
		
		var matchId = $('#racer2Won').attr('data-matchId');
		var winningRacerId = $('#racer2Won').attr('data-racerId');
		var losingRacerId = $('#racer1Won').attr('data-racerId');

		PostWinner(matchId, winningRacerId, losingRacerId);
		this.showWinner(winningRacerId, $(racer2Won).text());
	},
	render: function () {

		var m = this.model.toJSON();
		this.$el.html(this.template({ model: m }));
		if(m.Winner.RacerId === 0) {
			this.$el.find('#winner').hide();
		}
		return this;
	},
	showWinner: function(racerId, racerName) {
		$('#winner span').html('#' + racerId + ' ' + racerName);
		$('#winner').show();
	
	}
});

// -----------------------------------------------------------------------------

var PeopleView = Backbone.View.extend({
	tagName: "div",
	template: _.template($('#people-template').html()),
	render: function () {
		this.$el.html(this.template({ list:this.collection.toJSON() }));
		return this;
	}
});

// -----------------------------------------------------------------------------

var SponsorView = Backbone.View.extend({
	tagName: "div",
	template: _.template($('#sponsor-template').html()),
	render: function () {
		this.$el.html(this.template());
		return this;
	}
});

// -----------------------------------------------------------------------------

var FakeSponsorView = Backbone.View.extend({
	tagName: "div",
	template: _.template($('#fakesponsor-template').html()),
	render: function () {
		this.$el.html(this.template());
		return this;
	}
});

// ROUTER =====================================================================

var App = Backbone.Router.extend({
	routes: {
		'home': 'home',
		'brackets': 'bracketList',
		'brackets/:id': 'roundList',
		'rounds/:id': 'matchList',
		'matches/:id': 'matchItem',
		'matches/:id/*update': 'matchItem',
		'people': 'personList',
		'sponsors': 'sponsorsList',
		'fakesponsors': 'fakeSponsorsList'
	},
	home: function () {
		var view = new HomeView();
		$("#main").html(view.render().el);
			var mytoken = '25329.f59def8.1a9eb7a77f2b46eeb5cec55fa3457d6d',
				pullcount = 200;
			function instagram() {
				var token = mytoken,
					count = pullcount;
				    $.ajax({
				        type: "GET",
				        dataType: "jsonp",
				 		async: true,
				        cache: false,
				        url: 'https://api.instagram.com/v1/users/self/media/recent?access_token='+token+'&count='+count+'',
				        success: function(data) {
				        	$.each(data.data, function(index, value){
								var id = this.id,
								 	seconds = index * 2;
									$('#instagram').addClass("animate");
									$('#instagram.animate').append('<li><img style="-moz-animation-name: big; -moz-animation-delay:'+seconds+'s; -webkit-animation-name: big; -webkit-animation-delay:'+seconds+'s;" data-id="'+id+'" src="'+this.images.standard_resolution.url+'" alt="" /></li>');
					         });   
				        },
						complete: function(){
							$('#instagram li:last-child img').on('webkitAnimationEnd oAnimationEnd msAnimationEnd animationend', function() {
								$("#instagram li").each(function(){
										$(this).children("img").css({
											"-moz-animation-name":  "off",
											"-webkit-animation-name":  "off"	
										});
										setTimeout(function(){
											$("#instagram li").each(function(){
												$(this).children("img").css({
													"-moz-animation-name":  "big",
													"-webkit-animation-name":  "big"
												});
											});
										}, 10);
								});	
							});
						}
				    });
			}
			function newphoto() {
				var token = mytoken,
					count = pullcount;
				$.ajax({
				        type: "GET",
				        dataType: "jsonp",
				 		async: true,
				        cache: false,
				        url: 'https://api.instagram.com/v1/users/self/media/recent?access_token='+token+'&count='+count+'',
						success: function(data) {
							var id = data.data[0].id;
							var photoID1 = data.data[0].id;
							var photoID2 = $('#instagram img:nth-child(1)').attr('data-id');							
							if(photoID1 != photoID2) {
								$('#instagram').prepend('<li><img  style="-moz-animation-name: big; -moz-animation-delay:2s; -webkit-animation-name: big; -webkit-animation-delay:2s;" data-id="'+id+'" src="'+data.data[0].images.standard_resolution.url+'" alt="" /></li>');
								$("#instagram li").each(function(index){
									var seconds = index * 2;
									console.log("this fired")
									$(this).children('img').css({
										"-moz-animation-delay": seconds+"s",
										"-webkit-animation-delay": seconds+"s"
									});
								});
							}
						}
				});
			}	 
		instagram();
		(function poll(){
				setTimeout(function(){
					newphoto();
					poll();
				}, 5000); //pull for new photos every 5 secs. allowed up to 5000 requests hour
		})();
	},
	bracketList: function () {
		brackets.fetch({
			success: function (model, response) {
				var view = new BracketView({ collection: brackets });
				$("#main").html(view.render().el);
			}
		});
	},
	roundList: function (id) {
		rounds.BracketId = id;
		rounds.fetch({
			success: function (model, response) {
				var view = new RoundView({ collection: rounds });
				$('#main').html(view.render().el);
			}
		});
	},
	matchList: function (id) {

		$('#main').html('<div id="header" class="matchListHeader"></div><div id="detail"></div>');

		matchHeader.RoundId = id;
		matchHeader.fetch({
			success: function (model, response) {
				var view = new MatchHeaderView({ model: matchHeader });
				$('#header').append(view.render().el);
			}
		});

		matches.RoundId = id;
		matches.fetch({
			success: function (model, response) {
				var view = new MatchView({ collection: matches });
				var $list = $(view.render().el);
				$('#detail').append($list);
			}
		});
		
	},
	matchItem: function (id) {
		race.MatchId = id;
		race.fetch({
			success: function (model, response) {
				var view = new RaceView({ model: race });
				$('#main').html(view.render().el);
			}
		});
	},
	personList: function () {
		people.fetch({
			success: function (model, response) {
				var view = new PeopleView({ collection: people });
				$('#main').html(view.render().el);
			}
		});
	},
	sponsorsList: function () {
		var view = new SponsorView();
		$('#main').html(view.render().el).parents("body");
	},
	fakeSponsorsList: function () {
		var view = new FakeSponsorView();
		$('#main').html(view.render().el);
	}
});

// =============================================================================

$(function () {
	window.app = new App();
	Backbone.history.start();
	// window.app.navigate('brackets');
});