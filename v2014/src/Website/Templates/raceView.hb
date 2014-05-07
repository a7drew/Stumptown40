<div class="racerView">
    <div class="meta">Race <span class="value">{{currentRound}}</span></div>
	<div class="vs"><img src="../Images/vs.png" alt="" /></div>
	<div class="racers cards">
		<div class="racer1 racer {{winner}}" data-id="{{racer1Id}}">
				<div class="back"></div>
				<div class="card">
					<div class="avatar"><img src="https://dl.dropboxusercontent.com/u/3743394/{{racer1Id}}.jpg" alt="" class="car" /></div>
					<div class="racername">
						<span class="number"><p>{{racer1Id}}</p></span>
						<span class="name"><p>{{racer1}}</p></span>
					</div> 
				</div>
		</div>
		<div class="racer2 racer {{winner}}" data-id="{{racer2Id}}">
				<div class="back"></div>
				<div class="card">
					<div class="avatar"><img src="https://dl.dropboxusercontent.com/u/3743394/{{racer2Id}}.jpg" alt="" class="car" /></div>
					<div class="racername">
						<span class="number"><p>{{racer2Id}}</p></span>
						<span class="name"><p>{{racer2}}</p></span>
					</div> 
				</div>
		</div>
	</div>
	
	<div class="racer1 upcomingracer">
		<div class="back"></div>
		<div class="card" data-id="{{upcomingracer1Id}}">
			<div class="avatar"><img src="https://dl.dropboxusercontent.com/u/3743394/{{upcomingracer1Id}}.jpg" alt="" class="car" /></div>
			<div class="racername">
				<span class="number"><p>{{upcomingracer1Id}}</p></span>
				<span class="name"><p>{{nextRacer1}}</p></span>
			</div> 
		</div>
	</div>

	<div class="racer2 upcomingracer">
		<div class="back"></div>
		<div class="card" data-id="{{upcomingracer2Id}}">
			<div class="avatar"><img src="https://dl.dropboxusercontent.com/u/3743394/{{upcomingracer2Id}}.jpg" alt="" class="car" /></div>
			<div class="racername">
				<span class="number"><p>{{upcomingracer2Id}}</p></span>
				<span class="name"><p>{{nextRacer2}}</p></span>
			</div> 
		</div>
	</div>
		
</div>