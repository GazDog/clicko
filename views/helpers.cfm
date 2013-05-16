<cffunction name="flashMessageTag" access="public" output="false" returnType="string" hint="Flashes any avalable messages in the flash.">
	<cfset local.html = "">
	<cfif flashKeyExists("message")>
		<cfsavecontent variable="local.html">
			<cfoutput>
				<div class="alert-message block-message #flash('messageType')# fade in" data-alert="alert">
					<a href="##" class="close">&times;</a>
					<p>#flash("message")#</p>
				</div>
			</cfoutput>
		</cfsavecontent>
	</cfif>
	<cfreturn local.html>
</cffunction>

<!--- <cffunction name="formatDate" access="public" output="false" returnType="string" hint="Formats a date/time string.">
	<cfargument name="string" type="date" required="true" hint="The date to format">
	<cfreturn DateFormat(arguments.string, "medium")>
</cffunction> --->

<cffunction name="pageTitle" access="public" output="false" returnType="string" hint="Sets and displays page title">
	<cfargument name="title" type="string" required="true">
	<cfset var loc = {} />
	<!--- NOTE: pageTitle variable also used in _htmlOpen partial for html title tag--->
	<cfset contentFor(pageTitle=arguments.title)>
	<cfsavecontent variable="loc.html">
		<cfoutput>
			<div class="page-header">
				<h2>#includeContent("pageTitle")#</h2>
			</div>
		</cfoutput>
	</cfsavecontent>
	<cfreturn loc.html>
</cffunction>