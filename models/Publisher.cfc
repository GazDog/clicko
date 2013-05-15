<cfcomponent extends="Model" output="false">

	<cffunction name="init">
		<cfset hasMany(name="Assets")>
		<cfset belongsTo(name="Customer")>
	</cffunction>
	
</cfcomponent>