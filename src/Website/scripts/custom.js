// MODELS ======================================================================

var Bracket = Backbone.Model.extend({});

var Brackets = Backbone.Collection.extend({
	model: Bracket,
	sync: function(method, model, options) {  
		options.timeout = 10000;  
		options.dataType = "jsonp";  
		return Backbone.sync(method, model, options);  
	},
	url: function() {
		return "http://stumptown40.cloudapp.net/brackets";
	}
});

var brackets = new Brackets();

// -----------------------------------------------------------------------------

var Round = Backbone.Model.extend({});

var Rounds = Backbone.Collection.extend({
	model: Round,
	url: function () {
		return "http://stumptown40.cloudapp.net/rounds/index/" + this.BracketId;
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
		return "http://stumptown40.cloudapp.net/matches/header/" + this.RoundId;
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
		return "http://stumptown40.cloudapp.net/matches/index/" + this.RoundId;
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
		return "http://stumptown40.cloudapp.net/matches/detail/" + this.MatchId;
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
	url: "http://stumptown40.cloudapp.net/racers",
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
		url: 'http://stumptown40.cloudapp.net/matches/update',
		data: { matchId: matchId, winningRacerId:winningRacerId, losingRacerId:losingRacerId }
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

		alert('show winner here');

	},
	racer2Won : function () {
		
		var matchId = $('#racer2Won').attr('data-matchId');
		var winningRacerId = $('#racer2Won').attr('data-racerId');
		var losingRacerId = $('#racer1Won').attr('data-racerId');

		PostWinner(matchId, winningRacerId, losingRacerId);
		
		alert('show winner here');
	},
	render: function () {
		this.$el.html(this.template({ model: this.model.toJSON() }));
		return this;
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

		$('#main').html('<div id="header"></div><div id="detail"></div>');

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
		$('#main').html(view.render().el);
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