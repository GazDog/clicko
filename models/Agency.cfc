<cfcomponent extends="Model" output="false">

	<cffunction name="init">
		<cfset hasMany(name="Customers")>
		<cfset hasMany(name="Users")>
		<!--- let's see if this hasOne is needed --->
		<cfset hasOne(name="Customer")>
	</cffunction>
	
</cfcomponent>