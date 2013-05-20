<cfcomponent extends="Model" output="false">

	<cffunction name="init">
		<!--- associations --->
		<cfset hasMany(name="Customers")>
		<cfset hasMany(name="Users")>
		<cfset hasOne(name="Customer")><!--- let's see if this hasOne is needed --->
		<!--- custom properties --->
		<cfset property(name="accessLevel", defaultValue=0)>
		<!--- validation --->
		<cfset validatesFormatOf(property="email", type="email")>
	</cffunction>
	
</cfcomponent>