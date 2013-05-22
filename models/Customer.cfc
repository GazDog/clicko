<cfcomponent extends="Model" output="false">

	<cffunction name="init">
		<cfset hasMany(name="Campaigns")>
		<cfset hasMany(name="Publishers")>
		<cfset belongsTo(name="Agency")>
		<!--- validation --->
		<cfset validatesFormatOf(property="email", type="email")>
		<cfset validatesFormatOf(property="website", type="url")>
	</cffunction>
	
</cfcomponent>