﻿// MODELS ======================================================================
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

    if ($.cookie('stumptown40UserMode') != '0')
        return;

    $.ajax({
        type: 'post',
        url: webSvcUrl + '/matches/update',
        data: 
        {
            matchId: matchId,
            winningRacerId: winningRacerId,
            losingRacerId: losingRacerId,
            pin: $.cookie('stumptown40UserModePin')
        },
        success: function ()
        {
            $('#raceTemplate').append('<input id="hiddenPostedWinner" type="hidden" value="' + winningRacerId + '" />');
        }
    });

}

function SetUrl(url)
{
    if ($.cookie('stumptown40UserMode') != '0')
        return;

    if (!url) {
        url = window.location.hash;
    }

    $.ajax({
        url: webSvcUrl + '/home/seturl',
        type: 'GET',
        dataType: 'jsonp',
        data:
        {
            url: url,
            pin: $.cookie('stumptown40UserModePin')
        }
    });
}

function GetUrl()
{
    $.ajax({
        type: 'get',
        url: webSvcUrl + '/home/geturl',
        dataType: 'jsonp',
        data:
        {
            e: 'stumptown40'
        },
        success: function (e)
        {
            if(window.location.hash != e.url)
                window.location.href = e.url;
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
    initialize: function ()
    {
        _.bindAll(this, 'render');
    },
    events: {
        "click #racer1Won": "racer1Won",
        "click #racer2Won": "racer2Won"
    },
    racer1Won: function ()
    {
        if ($.cookie('stumptown40UserMode') != '0')
            return;

        var matchId = $('#racer1Won').attr('data-matchId');
        var winningRacerId = $('#racer1Won').attr('data-racerId');
        var losingRacerId = $('#racer2Won').attr('data-racerId');

        PostWinner(matchId, winningRacerId, losingRacerId);

		var d = new Date();
		var n = d.getSeconds();

        SetUrl(window.location.hash + '/update' + n);
        // window.location.href += '/update';

        $('div.racers div.racer1 div.card').addClass('winner');
        $('div.racers div.racer2 div.card').removeClass('winner');
    },
    racer2Won: function ()
    {
        if ($.cookie('stumptown40UserMode') != '0')
            return;

        var matchId = $('#racer2Won').attr('data-matchId');
        var winningRacerId = $('#racer2Won').attr('data-racerId');
        var losingRacerId = $('#racer1Won').attr('data-racerId');

        PostWinner(matchId, winningRacerId, losingRacerId);

		var d = new Date();
		var n = d.getSeconds();
    	
        SetUrl(window.location.hash + '/update' + n);
        
        // window.location.href += '/update';

        $('div.racers div.racer2 div.card').addClass('winner');
        $('div.racers div.racer1 div.card').removeClass('winner');
    },
    render: function ()
    {

        var m = this.model.toJSON();
        this.$el.html(this.template({ model: m }));
        if (m.Winner.RacerId === 0)
        {
            this.$el.find('#winner').hide();
        }
        return this;
    }
});

// -----------------------------------------------------------------------------

var AdminView = Backbone.View.extend({
    tagName: "div",
    template: _.template($('#admin-template').html()),
    initialize: function ()
    {
        _.bindAll(this, 'render');
    },
    events: {
        "click #btnSubmit": "btnSubmitClicked"
    },
    btnSubmitClicked: function ()
    {
        var radioButton = $('#adminTemplate input:checked');

        $.cookie('stumptown40UserMode', radioButton.val().toString(), { expires: 7, path: '/' });
        $.cookie('stumptown40UserModePin', $('#txtPin').val().toString(), { expires: 7, path: '/' });

        switch ($.cookie('stumptown40UserMode'))
        {
            case '0':
                alert('user mode is "Leader"');
                break;
            case '1':
                alert('user mode is "Follower"');
                window.setInterval(GetUrl, 1000);
                break;
            case '2':
                alert('user mode is "Off"');
                break;
        }

        window.location.href = '#brackets';
    },
    render: function ()
    {
        this.$el.html(this.template());
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
        'rounds/:id/m:matchId': 'matchList',
        'rounds/:id': 'matchList',
        'matches/:id': 'matchItem',
        'matches/:id/*update': 'matchItem',
        'people': 'personList',
        'sponsors': 'sponsorsList',
        'fakesponsors': 'fakeSponsorsList',
        'admin': 'admin'
    },
    home: function ()
    {
        SetUrl();
        var view = new HomeView();
        $("#main").html(view.render().el);
        var mytoken = '51853638.1fb234f.976879fb4353497caa70fa47810b6e3d', //ryan 25329.f59def8.1a9eb7a77f2b46eeb5cec55fa3457d6d, stumptown 51853638.1fb234f.976879fb4353497caa70fa47810b6e3d
				pullcount = 200;
        function instagram()
        {
            var token = mytoken,
					count = pullcount;
            $.ajax({
                type: "GET",
                dataType: "jsonp",
                async: true,
                cache: false,
                url: getInstagramUrl(),
                success: function (data)
                {
                    window.instagramData = data.data;

                    $.each(data.data, function (index, value)
                    {
                        var id = this.id,
							seconds = index * 2,
							random = (Math.floor(Math.random() * 80)/10)*2,
							racernumberslide = this.caption.text.replace(/^#/, '');
							$('#instagram').addClass("animate");
                        $('#instagram.animate').append('<li><img style="-moz-animation-name: big; -moz-animation-delay:' + random + 's; -webkit-animation-name: big; -webkit-animation-delay:' + random + 's;" data-id="' + id + '" src="' + this.images.low_resolution.url + '" alt="" /><span class="racernumberslide">'+racernumberslide+'</span></li>');
                    });
                },
                complete: function ()
                {
                  /*  $('#instagram li:last-child img').on('webkitAnimationEnd oAnimationEnd msAnimationEnd animationend', function ()
                    {
                        $("#instagram li").each(function ()
                        {
                            $(this).children("img").css({
                                "-moz-animation-name": "off",
                                "-webkit-animation-name": "off"
                            });
                            setTimeout(function ()
                            {
                                $("#instagram li").each(function (index)
                                {
									var seconds = index * 2,
										random = (Math.floor(Math.random()*10)) / 2;
                                    $(this).children("img").css({
                                        "-moz-animation-name": "big",
                                        "-webkit-animation-name": "big",
										"-webkit-animation-delay": random + "s",
										"-moz-animation-delay": random + "s"
                                    });
                                });
                            }, 0);
                        });
                    });*/

					 /*  $('#instagram li:last-child img').on('webkitAnimationEnd oAnimationEnd msAnimationEnd animationend', function ()
	                    {
	                        $("#instagram li").each(function ()
	                        {
	                            $(this).children("img").css({
	                                "-moz-animation-name": "off",
	                                "-webkit-animation-name": "off"
	                            });
	                            setTimeout(function ()
	                            {
	                                $("#instagram li").each(function (index)
	                                {
										var seconds = index * 2,
											random = (Math.floor(Math.random()*10)) / 2;
	                                    $(this).children("img").css({
	                                        "-moz-animation-name": "big",
	                                        "-webkit-animation-name": "big",
											"-webkit-animation-delay": random + "s",
											"-moz-animation-delay": random + "s"
	                                    });
	                                });
	                            }, 0);
	                        });
	                    });*/
                }
            });
        }
        function newphoto()
        {
            var token = mytoken,
					count = pullcount;
            $.ajax({
                type: "GET",
                dataType: "jsonp",
                async: true,
                cache: false,
                url: getInstagramUrl(),
                success: function (data)
                {
                    var id = data.data[0].id,
                     	photoID1 = data.data[0].id,
                     	photoID2 = $('#instagram img:nth-child(1)').attr('data-id'),
						racernumberslide = data.data[0].caption.text.replace(/^#/, '');
                    if (photoID1 != photoID2)
                    {
                        $('#instagram').prepend('<li><img data-id="' + id + '" src="' + data.data[0].images.low_resolution.url + '" alt="" /><span class="racernumberslide">'+racernumberslide+'</span></li>');

						$("#instagram li").each(function ()
                        {
                            $(this).children("img").css({
                                "-moz-animation-name": "off",
                                "-webkit-animation-name": "off"
                            });
                            setTimeout(function ()
                            {
                                $("#instagram li").each(function (index)
                                {
									var seconds = index * 2,
										random = (Math.floor(Math.random() * 80)/10)*2;
                                    $(this).children("img").css({
                                        "-moz-animation-name": "big",
                                        "-webkit-animation-name": "big",
										"-webkit-animation-delay": random + "s",
										"-moz-animation-delay": random + "s"
                                    });
                                });
                            }, 0);
                        });
                        

                    }
                }
            });
        }
        instagram();
        (function poll()
        {
            if (window.location.hash != '#home')
                return;

            setTimeout(function ()
            {
                newphoto();
                poll();
            }, 5000); //pull for new photos every 5 secs. allowed up to 5000 requests hour
        })();
		$('#ipadMenu')[0].scrollIntoView();
    },
    bracketList: function ()
    {
        SetUrl();
        brackets.fetch({
            success: function (model, response)
            {
                var view = new BracketView({ collection: brackets });
                $("#main").html(view.render().el);
            }
        });
    },
    roundList: function (id, matchId)
    {
        SetUrl();
        rounds.BracketId = id;
        rounds.fetch({
            success: function (model, response)
            {
                var view = new RoundView({ collection: rounds });
                $('#main').html(view.render().el);
            }
        });
    },
    matchList: function (id, matchId)
    {
        SetUrl();
        $('#main').html('<div id="header" class="matchListHeader"></div><div id="detail"></div>');

        matchHeader.RoundId = id;
        matchHeader.fetch({
            success: function (model, response)
            {
                var view = new MatchHeaderView({ model: matchHeader });
                $('#header').append(view.render().el);
            }
        });

        matches.RoundId = id;
        matches.fetch({
            success: function (model, response)
            {
                var view = new MatchView({ collection: matches });
                var $list = $(view.render().el);

                $list.find('#matchList .avatar img').each(function ()
                {
                    var racerId = $(this).attr('data-racerId');
                    $(this).attr('src', GetAvatarUrl(racerId));
                });

                $('#detail').append($list);

                if (matchId)
                {
                    var selector = 'a[href="#matches/' + matchId + '"]';
                    $(selector)[0].scrollIntoView();
                }
            }
        });

    },
    matchItem: function (id)
    {
        SetUrl();
        race.MatchId = id;
        race.fetch({
            success: function (model, response)
            {
                // model.racer1Url = '/images/pinewoodcar.png';
                var view = new RaceView({ model: race });
                $('#main').html(view.render().el);
                $('.racer1 .avatar img').attr('src', GetAvatarUrl(response.Racer1.RacerId));
                $('.racer2 .avatar img').attr('src', GetAvatarUrl(response.Racer2.RacerId));
				$('#ipadMenu')[0].scrollIntoView();
            }
        });
    },
    personList: function ()
    {
        SetUrl();
        people.fetch({
            success: function (model, response)
            {
                var view = new PeopleView({ collection: people });
                $('#main').html(view.render().el);
            }
        });
    },
    sponsorsList: function ()
    {
        SetUrl();
        var view = new SponsorView();
        $('#main').html(view.render().el).parents("body");
		$('#ipadMenu')[0].scrollIntoView();
    },
    fakeSponsorsList: function ()
    {
        SetUrl();
        var view = new FakeSponsorView();
        $('#main').html(view.render().el);
    },
    admin: function ()
    {
        var view = new AdminView();
        $('#main').html(view.render().el);
    }
});

// =====

function GetAvatarUrl(racerId)
{
    if (!window.instagramData)
    {
        // hit pre-race page first to load instagram data!
        return '/images/default.jpg';
    }

    for (var x = 0; x < window.instagramData.length; x++)
    {
        var item = window.instagramData[x];

        if (item.tags.length > 0)
        {
            // only inspect the last tag to accomodate errors in previous tags
            if (item.tags[item.tags.length-1] == racerId)
            {
                return item.images.low_resolution.url;
            }
        }
    }

    // default image?
    return '/images/default.jpg';
}

function getInstagramUrl()
{
	//ryan 25329.f59def8.1a9eb7a77f2b46eeb5cec55fa3457d6d, stumptown 51853638.1fb234f.976879fb4353497caa70fa47810b6e3d
    var token = '51853638.1fb234f.976879fb4353497caa70fa47810b6e3d';
    var count = 200;

    return 'https://api.instagram.com/v1/users/self/media/recent?access_token=' + token + '&count=' + count;
}
// =============================================================================

$(function ()
{
    if ($.cookie('stumptown40UserMode') == null)
    {
        $.cookie('stumptown40UserMode', '2', { expires: 7, path: '/' }); // off
        $.cookie('stumptown40UserMode', 'xxx', { expires: 7, path: '/' });
    }

	$('#ipadMenu').click(function() {
		$('nav').toggleClass('on');
	});

    window.app = new App();
    Backbone.history.start();
    // window.app.navigate('brackets');
});