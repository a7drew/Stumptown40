<!--	<div>
		<h1>Current Race</h1>
		<p class="{{winner}}" data-id="{{racer1Id}}">{{racer1}} #{{racer1Id}}</p>
		<p class="{{winner}}" data-id="{{racer2Id}}">{{racer2}} #{{racer1Id}}</p>
	</div>

	<div>
		<h1>Upcoming Race</h1>
		<p>Racer #{{nextRacer1}}</p>
		<p>Racer #{{nextRacer2}}</p>
	</div>
-->
<div class="racerView">
       <div class="meta">Race <span class="value">{{currentRound}}</span></div>
	<div class="racers cards">
		<div class="racer1">
					<div class="card {{winner}}" data-id="{{racer1Id}}">
						<div class="avatar"><img src="http://distilleryimage11.s3.amazonaws.com/fab197429fc411e1a9f71231382044a1_7.jpg" alt="" class="car" /></div>
						<div class="racername">
							<span class="number"><p>{{racer1Id}}</p></span>
							<span class="racer1 racer name"><p>{{racer1}}</p></span>
						</div> 
					</div>
		</div>
		<div class="racer2">
				<div class="card  {{winner}}" data-id="{{racer2Id}}">
					<div class="avatar"><img src="http://distilleryimage11.s3.amazonaws.com/fab197429fc411e1a9f71231382044a1_7.jpg" alt="" class="car" /></div>
					<div class="racername">
						<span class="number"><p>{{racer2Id}}</p></span>
						<span class="racer2 racer name"><p>{{racer2}}</p></span>
					</div> 
				</div>
		</div>
	</div>
</div>