<cfcomponent extends="Controller">
	
	<cffunction name="init">
		<cfset super.init()>
	</cffunction>

	<cffunction name="index">
		
		<cfset assets = model("Asset").findAll()>

	</cffunction>

</cfcomponent>