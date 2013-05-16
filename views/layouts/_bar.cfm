<cfsilent>

	<cfimport taglib="/clicko/customtags/" prefix="tag">

	<cfif signedIn() AND params.controller neq "admin.login">
		<tag:head>
			<cfoutput>
				<style>
				.ui-autocomplete-category {
					font-weight: bold;
					padding: .2em .4em;
					margin: .8em 0 .2em;
					line-height: 1.5;
				}
				</style>
				<script>
				$.widget( "custom.catcomplete", $.ui.autocomplete, {
					_renderMenu: function( ul, items ) {
						var self = this,
							currentCategory = "";
						$.each( items, function( index, item ) {
							if ( item.category != currentCategory ) {
								ul.append( "<li class='ui-autocomplete-category'>" + item.category + "</li>" );
								currentCategory = item.category;
							}
							self._renderItem( ul, item );
						});
					}
				});
				$(function() {
					
					var data = "#urlFor(controller='admin.ajax', action='smartSearch', params='format=json&r=#CreateUUID()#')#";
					
					var whenSelected = function(event, ui) {

						<!--- TODO: change this to a route..? --->
						self.location="/admin/" + ui.item.category.toLowerCase() + 's/show/' + ui.item.id;
					}
					
					var whenClosed = function(event, ui) {
						$( "##search" ).val("");
					}
					
					$( "##search" ).catcomplete({
						delay: 1
						,source: data
						,select: whenSelected
						,close: whenClosed
					});
				});
				</script>
			</cfoutput>
		</tag:head>
	</cfif>
	
</cfsilent>
<cfoutput>
<div id="navbar" class="navbar navbar-fixed-top">
	<div class="navbar-inner">
		<div class="container">
			<!-- .btn-navbar is used as the toggle for collapsed navbar content -->
			<a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</a>
			#linkTo(controller="admin.dashboard", action="index", text=get("appName"), class="brand")#
			<cfif signedIn() AND params.controller neq "admin.login">
			<div class="nav-collapse">
				<ul class="nav">
					
					<li>#linkTo(controller="admin.dashboard", action="index", text="Dashboard")#</li>
					
					<li class="dropdown">
						<a href="##" class="dropdown-toggle" data-toggle="dropdown">Add<b class="caret"></b></a>
						<ul class="dropdown-menu">
							<li>#linkTo(controller="admin.pages", action="newOne", text="Page")#</li>
							<li>#linkTo(controller="admin.items", action="new", text="Item")#</li>
						</ul>
					</li>
					<li class="dropdown">
						<a href="##" class="dropdown-toggle" data-toggle="dropdown">Admin<b class="caret"></b></a>
						<ul class="dropdown-menu">
							<li>#linkTo(controller="admin.site", action="edit", text="Site")#</li>
							<li>#linkTo(controller="admin.pages", action="index", text="Pages")#</li>
							<li>#linkTo(controller="admin.items", action="index", text="Items")#</li>
							<li>#linkTo(controller="admin.menuLinks", action="index", text="Menu")#</li>
							<li>#linkTo(controller="admin.categories", action="index", text="Categories")#</li>
							<li>#linkTo(controller="admin.attributeOptions", action="index", text="Attributes")#</li>
							<li>#linkTo(controller="admin.people", action="index", text="Users")#</li>
							<li>#linkTo(controller="admin.contacts", action="index", text="Contacts")#</li>
						</ul>
					</li>
				</ul>
				<form class="navbar-search pull-left">
				  <input type="text" class="search-query" id="search" placeholder="Search">
				</form>
				<ul class="nav pull-right">
					<li class="dropdown">
						<a href="##" class="dropdown-toggle" data-toggle="dropdown">#currentUser.firstName#<b class="caret"></b></a>
						<ul class="dropdown-menu">
							<!--- <li>#linkTo(controller="admin.people", action="edit", key=res.me.id, text="Edit Profile")#</li> --->
							<li>#linkTo(route="logout", text="Log out", params="clear=true")#</li>
						</ul>
					</li>
				</ul>
			</div>
			</cfif>
		</div>
	</div>
</div>
</cfoutput>