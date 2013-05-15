<cfcomponent extends="Model" output="false">

	<cffunction name="init">
		<cfset hasMany(name="Campaigns")>
		<cfset hasMany(name="Publishers")>
		<cfset belongsTo(name="Agency")>
	</cffunction>
	
</cfcomponent>