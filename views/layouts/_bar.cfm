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
			#linkTo(controller="#adminNamespace(currentUser)#.dash", action="index", text=get("appName"), class="brand")#
			<div class="nav-collapse">
				<cfif currentUser.isAdministrator>
					#includePartial("/layouts/masterMenu.cfm")#
				<cfelse>
					#includePartial("/layouts/adminMenu.cfm")#
				</cfif>
				<ul class="nav pull-right">
					<li class="dropdown">
						<a href="##" class="dropdown-toggle" data-toggle="dropdown">#currentUser.firstName#<b class="caret"></b></a>
						<ul class="dropdown-menu">
							<!--- <li>#linkTo(controller="admin.people", action="edit", key=res.me.id, text="Edit Profile")#</li> --->
							<li>#linkTo(route="logout", text="Log out")#</li>
						</ul>
					</li>
				</ul>
			</div>
		</div>
	</div>
</div>
</cfoutput>