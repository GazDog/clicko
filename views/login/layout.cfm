<cfoutput>
	#includePartial("/layouts/open")#
	<!--- top bar --->
	<div id="navbar" class="navbar navbar-fixed-top">
		<div class="navbar-inner">
			<div class="container">
				<span class="brand">#get("appName")#</span>
			</div>
		</div>
	</div>
	<!--- messages --->
	<div class="container" id="flashContainer" align="center">
		#flashMessageTag()#
	</div>
	<div class="container">
		#includeContent()# 
		#includePartial("/layouts/footer")#
	</div>
	#includePartial("/layouts/close")#
</cfoutput>