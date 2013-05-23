<cfcomponent extends="Model" output="false">

	<cffunction name="init">
		<cfset hasMany(name="Assets")>
		<cfset belongsTo(name="Customer")>
		<!--- validation --->
		<cfset validatesFormatOf(property="email", type="email")>
		<cfset validatesFormatOf(property="website", type="url")>
	</cffunction>
	
</cfcomponent>