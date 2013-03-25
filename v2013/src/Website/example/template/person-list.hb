{{>searchbox}}

<p>Her er en liste med klikkbare navn:</p>

<div id="content">
	<ul id="people">
	{{#each people }}
		<li>{{ name }}</li>
	{{/each}}
	</ul>
</div>

