<div class="racerView">
	<div>
		<h1>Current Race</h1>
		<p class="{{winner}}" data-id="{{racer1Id}}">Racer #{{racer1}}</p>
		<p class="{{winner}}" data-id="{{racer2Id}}">Racer #{{racer2}}</p>
	</div>

	<div>
		<h1>Upcoming Race</h1>
		<p>Racer #{{nextRacer1}}</p>
		<p>Racer #{{nextRacer2}}</p>
	</div>
</div>




	<div id="raceTemplate" class="view raceTemplate">
        <div class="meta"><a href="#rounds/<%= model.RoundId %>/m<%= model.MatchId %>">Round <span class="value"><%= model.RoundNumber %></span></a></div>
		<div class="racers cards">
			<div class="racer1">
						<div class="card {{winner}}">
							<div class="avatar"><img src="" alt="" class="car" /></div>
							<div class="racername">
								<span class="number"><p>{{racer1}}</p></span>
								<a id="racer1Won" data-matchId="<%= model.MatchId %>" data-racerId="<%= model.Racer1.RacerId %>" href="javascript:;" class="racer1 racer name"><p><%= model.Racer1.Name %></p></a>
							</div> 
						</div>
			</div>
			<div class="racer2">
					<div class="card <% if(model.Winner.RacerId === model.Racer2.RacerId) { %>winner<% }%>">
					<div class="avatar"><img src="" alt="" class="car" /></div>
						<div class="racername">
							<span class="number"><p><%= model.Racer2.RacerId %></p></span>
							<a id="racer2Won" data-matchId="<%= model.MatchId %>" data-racerId="<%= model.Racer2.RacerId %>" href="javascript:;" class="racer2 racer name"><p><%= model.Racer2.Name %></p></a>
						</div> 
					</div>
			</div>
			
			<div id="winner" class="readout">
				Winner:
				<span>
					#<%= model.Winner.RacerId %> <%= model.Winner.Name %>
				</span>
			</div>

		</div>
	</div>