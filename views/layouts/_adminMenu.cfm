<cfoutput>
	<ul class="nav">

		<li class="dropdown">
			<a href="##" class="dropdown-toggle" data-toggle="dropdown">New<b class="caret"></b></a>
			<ul class="dropdown-menu">
				<!--- TODO: limit customers by permission --->
				<li>#linkTo(controller="admin.customers", action="new", text="Customer")#</li>
				<li>#linkTo(controller="admin.publishers", action="new", text="Publisher")#</li>
				<li>#linkTo(controller="admin.campaigns", action="new", text="Campaign")#</li>
				<li>#linkTo(controller="admin.assets", action="new", text="Asset")#</li>
			</ul>
		</li>

		<li>#linkTo(controller="admin.customers", action="index", text="Customers")#</li>
		<li>#linkTo(controller="admin.publishers", action="index", text="Publishers")#</li>
		<li>#linkTo(controller="admin.campaigns", action="index", text="Campaigns")#</li>
		<li>#linkTo(controller="admin.assets", action="index", text="Assets")#</li>
		
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
</cfoutput>