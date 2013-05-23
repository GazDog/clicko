<cffunction name="shortURL" returntype="string" access="public">
	<cfargument name="string" required="true" type="string">
	<cfset var loc = {}>
	<cfset loc.return = arguments.string>
	<cfset loc.return = ReplaceNoCase(loc.return, "http://", "", "one")>
	<cfset loc.return = ReplaceNoCase(loc.return, "https://", "", "one")>
	<cfset loc.return = ReplaceNoCase(loc.return, "www.", "", "one")>
	<cfreturn loc.return>
</cffunction>

<cffunction name="santiseURL" access="public" output="false" returntype="string" hint="formats a time for display">
	<cfargument name="string" type="string" required="true">
	<cfreturn (Left(arguments.string,4) neq "http" ? "http://" : "") & arguments.string>
</cffunction>

<cffunction name="ifEmpty" access="public" output="false" returntype="string" hint="formats a time for display">
	<cfargument name="string1" type="string" required="true" hint="string to test">
	<cfargument name="string2" type="string" required="false" default="#arguments.string1#" hint="string to display if not empty (defaults to string 1)">
	<cfargument name="string3" type="string" required="false" default="--" hint="string to display if empty">
	<cfreturn arguments.string1 eq "" ? arguments.string3 : arguments.string2>
</cffunction>

<!--- should this be in string or date utilities? --->
<!--- combines the formatDate and isEnpty functions --->
<cffunction name="showDate" access="public" output="false" returntype="string" hint="formats a time for display">
	<cfargument name="date" type="string" required="true">
	<cfset var loc = {}>
	<cfset loc.dateString = arguments.date>
	<cfif arguments.date neq "">
		<cfset loc.dateString = formatDate(arguments.date)>
	</cfif>
	<cfreturn ifEmpty(arguments.date, loc.dateString)>
</cffunction>