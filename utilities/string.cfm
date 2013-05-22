<cffunction name="shortURL" returntype="string" access="public">
	<cfargument name="string" required="true" type="string">
	<cfset var loc = {}>
	<cfset loc.return = arguments.string>
	<cfset loc.return = replaceNoCase(loc.return, "http://", "", "one")>
	<cfset loc.return = replaceNoCase(loc.return, "https://", "", "one")>
	<cfset loc.return = replaceNoCase(loc.return, "www.", "", "one")>
	<cfreturn loc.return>
</cffunction>