<cfcomponent extends="Model" output="false">

	<cffunction name="init">
		<cfset belongsTo(name="Customer")>
		<cfset hasMany(name="Assets")>

	</cffunction>
	
</cfcomponent>