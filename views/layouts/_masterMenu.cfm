<cfoutput>
	<ul class="nav">

		<li class="dropdown">
			<a href="##" class="dropdown-toggle" data-toggle="dropdown">Add<b class="caret"></b></a>
			<ul class="dropdown-menu">
				<li>#linkTo(controller="master.administrators", action="new", text="Admin")#</li>
				<li>#linkTo(controller="master.agencies", action="new", text="Agency")#</li>
			</ul>
		</li>

		<li>#linkTo(controller="master.agencies", action="index", text="Agencies")#</li>
		<li>#linkTo(controller="master.administrators", action="index", text="Admins")#</li>
		
		<!--- 
			add more dropdowns here...
		<li class="dropdown">
			<a href="##" class="dropdown-toggle" data-toggle="dropdown">Add<b class="caret"></b></a>
			<ul class="dropdown-menu">
				<li>#linkTo(controller="admin.pages", action="newOne", text="Page")#</li>
				<li>#linkTo(controller="admin.items", action="new", text="Item")#</li>
			</ul>
		</li>
		 --->
		
	</ul>
	<form class="navbar-search pull-left">
	  <input type="text" class="search-query" id="search" placeholder="Search">
	</form>
</cfoutput>