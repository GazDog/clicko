<cfcomponent extends="Model" output="false">

	<cffunction name="init">
		<cfset hasMany(name="Clicks")>
		<cfset belongsTo(name="Campaign")>
		<cfset belongsTo(name="Publisher")>
	</cffunction>
	
</cfcomponent>